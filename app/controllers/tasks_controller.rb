class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: "desc")
  end

  def new
    @task = Task.new
  end
end
