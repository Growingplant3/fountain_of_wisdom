class LabelsController < ApplicationController
  before_action :sign_in_check
  before_action :set_label, only: %i[edit update destroy]

  def index
    @labels = current_user.labels
  end

  def new
    @label = current_user.labels.new
  end

  def create
    @label = current_user.labels.new(label_params)
    if @label.save
      flash[:notice] = "ラベルの登録に成功しました。"
      redirect_to labels_path
    else
      flash.now[:danger] = "ラベルの登録に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
    if @label.update(label_params)
      flash[:notice] = "ラベルの編集に成功しました。"
      redirect_to labels_path
    else
      flash.now[:danger] = "ラベルの編集に失敗しました。"
      render :edit
    end  
  end

  def destroy
    @label.destroy
    flash[:danger] = "ラベルの削除に成功しました。"
    redirect_to labels_path
  end

  private
  def label_params
    params.require(:label).permit(:name, :user_id)
  end

  def set_label
    @label = Label.find(params[:id])
  end
end
