class WelcomeController < ApplicationController
  layout 'root_index'

  def index
    @articles = Article.all
    @photos = Photo.all
  end
end
