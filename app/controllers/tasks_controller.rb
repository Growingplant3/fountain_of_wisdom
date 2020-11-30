class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: "desc")
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
  end

  private
  def task_params
    params.require(:task).permit(:name, :detail, :priority, :situation, :deadline)
  end
end
