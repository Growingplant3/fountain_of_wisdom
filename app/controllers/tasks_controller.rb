class TasksController < ApplicationController
  before_action :sign_in_check
  before_action :set_task, only: %i[show edit update destroy]

  def index
    if params[:sort_expired] || params[:sort_importance]
      @tasks = current_user.tasks.order(sort_type(params))
    else
      @tasks = current_user.tasks.order(created_at: "desc")
    end
    if params[:task]
      @tasks = @tasks.ambiguous_name(params[:task][:name]) unless params[:task][:name].blank?
      @tasks = @tasks.situation_value(params[:task][:situation]) unless params[:task][:situation].blank?
      unless params[:task][:label_id].blank?
        binding.pry
        label_id = Label.label_value(params[:task][:label_id]).where(user_id: current_user.id).pluck(:id)
        tasks_id = LabelTask.where(label_id: label_id.first).pluck(:task_id)
        @tasks = Task.where(id: tasks_id)
      end
    end
    @tasks = @tasks.page params[:page]
  end

  def new
    @task = current_user.tasks.new
    @task.labels.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:notice] = "タスクの登録に成功しました。"
      redirect_to task_path(@task)
    else
      flash.now[:danger] = "タスクの登録に失敗しました。"
      render :new
    end
  end

  def show
  end

  def edit
    @task.labels.new
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "タスクの編集に成功しました。"
      redirect_to tasks_path
    else
      flash.now[:danger] = "タスクの編集に失敗しました。"
      render :edit
    end  
  end

  def destroy
    @task.destroy
    flash[:danger] = "タスクの削除に成功しました。"
    redirect_to tasks_path
  end

  private
  def task_params
    params.require(:task).permit(:name, :detail, :priority, :situation, :deadline, label_ids: [])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def sort_type(params)
    if params[:sort_expired]
      flash[:notice] = "終了期限で並べ替えました。"
      { deadline: "desc" }
    elsif params[:sort_importance]
      flash[:notice] = "優先順位で並べ替えました。"
      { priority: "desc" }
    end
  end
end
