require 'sinatra'
require 'erubis'
require 'sinatra/contrib'
require 'sinatra/base'
require 'sqlite3'
set :erb, :escape_html => true

class Post
  attr_accessor :id, :title, :body

  def initialize(id: nil, title: nil, body: nil)
    @id    = id
    @title = title if title.length > 1
    @body  = body  if (1..256).include? body.length
  end
end

class Tag
  attr_accessor :id, :tag

  def initialize(id:, tag:)
    @id  = id
    @tag = tag
  end
end

db = SQLite3::Database.new "sinatra_microblog.db"

def update_from_db
  posts = []
  db = SQLite3::Database.new "sinatra_microblog.db"
  db.execute( "select * from posts" ) do |id, title, body|
    posts << Post.new(id: id, title: title, body: body)
  end
  posts
end

def find_and_create_tags(text)
  body_scan = text.scan(/#[@|@@|\$]?\w+/)
  body_scan.each do |tag|
    db = SQLite3::Database.new "sinatra_microblog.db"
    seq = db.execute "SELECT seq FROM SQLITE_SEQUENCE"
    db.execute "insert into tags values(?, ?)", seq.last[0].to_i + 1, tag[1..-1]
  end
end


get '/' do
  erb :index, :locals => {:posts => update_from_db }
end

get '/new' do
  erb :new, :locals => {:posts => update_from_db}
end

post '/new' do
  seq = db.execute "SELECT seq FROM SQLITE_SEQUENCE"
  db.execute "insert into posts values(?, ?, ?)", seq.last[0].to_i + 1, request.POST['title'].strip, request.POST['body'].strip
  find_and_create_tags(request.POST['body'])
  redirect '/posts'
end

get '/:id' do |id|
  return redirect '/' if id.to_s == 'posts'
  return "There's no post with #{id} for id present, m'lady *tips fedora*." if update_from_db.none? { |post| post.id == id.to_i }
  erb :show, :locals => {:post => update_from_db.detect { |post| post.id == id.to_i }, id: id.to_i}
end

get '/posts' do
  erb :index, :locals => {:posts => update_from_db}
end

get '/:id/delete' do |id|
  erb :delete, :locals => {:post => update_from_db.detect { |post| post.id == id.to_i }, :id => id}
end

delete("/:id") do |id|
  db.execute "delete from posts where id = ?", id.to_i
  db.execute "select id from posts"
  redirect "/"
end

