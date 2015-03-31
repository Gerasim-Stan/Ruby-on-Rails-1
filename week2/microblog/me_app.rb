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
  erb :index
  # 'Hello world!'
end

get '/new/' do

end

get '/post/:id' do |id|
  return "There's no post with #{id} for id present, m'lady *tips fedora*." if params[id].nil?
  # "#{params[id].title} #{params[id].body}"
end

get '/posts' do
  @post = Post
  'Yaay'
end
