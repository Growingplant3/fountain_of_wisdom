class LabelsController < ApplicationController
  def new
    @label = current_user.labels.new
  end

  def create
    @label = current_user.labels.new(label_params)
    if @label.save
      flash[:notice] = "ラベルの登録に成功しました。"
      redirect_to new_label_path
    else
      flash.now[:danger] = "ラベルの登録に失敗しました。"
      render :new
    end
  end

  private
  def label_params
    params.require(:label).permit(:name, :user_id)
  end

  def set_label
    @label = Label.find(params[:id])
  end
end
