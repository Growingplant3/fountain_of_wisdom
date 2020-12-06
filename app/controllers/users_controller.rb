class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:notice] = "アカウントの作成に成功しました。"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "アカウントの作成に失敗しました。"
      render :new
    end
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
