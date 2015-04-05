require 'sinatra'
require 'erubis'
set :erb, :escape_html => true

class Post
  attr_accessor :title, :body

  def initialize(title, body)
    @title = title if (1..40).include?  title.length
    @body  = body  if (1..256).include? body.length
  end


end

ids = 0
params = {}
params[(ids += 1).to_s] = Post.new('Wee', 'Amazing blog post! Beware, peasants!')
p params
get '/' do
  erb :index, :locals => {:params => params}
end

get '/new' do
  erb :new, :locals => {:params => params, :post_id => (ids += 1)}
end

post '/posts/:post_id' do
  "#{request.POST}"
end

get '/posts/:id' do |id|
  return "There's no post with #{id} for id present, m'lady *tips fedora*." if params[id].nil?
  "#{params[id].title}\n #{params[id].body}"
end

get '/posts' do
  @post = Post
  'Yaay'
end
