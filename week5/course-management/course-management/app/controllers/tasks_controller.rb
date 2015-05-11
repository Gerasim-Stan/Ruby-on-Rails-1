class TasksController < ApplicationController
  def index
    @tasks = Lecture.find(params[:lecture]).tasks
  end
end
