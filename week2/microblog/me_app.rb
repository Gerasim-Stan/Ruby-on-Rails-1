require 'sinatra'
require 'erubis'
require 'sinatra/contrib'
require 'sinatra/base'
set :erb, :escape_html => true

class Post
  attr_accessor :title, :body

  def initialize(title: nil, body: nil)
    @title = title if title.length > 1
    @body  = body  if (1..256).include? body.length
  end


end

ids = 0
posts = {}
posts[(ids += 1).to_s] = Post.new(title: 'Wee', body: 'Amazing blog post! Beware, peasants!')
p posts

get '/' do
  erb :index, :locals => {:posts => posts}
end

get '/new' do
  erb :new, :locals => {:posts => posts}
end

post '/new' do
  posts[(posts.keys.sort.last.to_i + 1).to_s] = Post.new(title: request.POST['title'].strip, body: request.POST['body'].strip)
  redirect '/posts'
end

get '/:id' do |id|
  p params
  return redirect '/' if id == 'posts'
  return "There's no post with #{id} for id present, m'lady *tips fedora*." if posts[id].nil?
  erb :show, :locals => {:post => posts[id], id: id}
end

get '/posts' do
  erb :index, :locals => {:posts => posts}
end

get '/:id/delete' do |id|
  erb :delete, :locals => {:post => posts[id.to_s], :id => id}
end

delete("/:id") do |id|
  posts.delete(id)
  redirect "/"
end
