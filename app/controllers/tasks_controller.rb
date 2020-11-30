class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: "desc")
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "タスクの登録に成功しました。"
      redirect_to tasks_path
    else
      flash.now[:alert] = "タスクの登録に失敗しました。"
      render :new
    end
  end

  private
  def task_params
    params.require(:task).permit(:name, :detail, :priority, :situation, :deadline)
  end
end
