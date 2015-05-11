class SolutionsController < ApplicationController
  def index
    @solutions = Task.find(params[:task]).solutions
  end
end
