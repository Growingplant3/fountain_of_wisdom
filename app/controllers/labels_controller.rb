class LabelsController < ApplicationController
  before_action :set_label, only: %i[destroy]

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
      redirect_to label_path(@label)
    else
      flash.now[:danger] = "ラベルの登録に失敗しました。"
      render :new
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
