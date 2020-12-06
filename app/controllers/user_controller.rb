class UserController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "アカウントの作成に成功しました。"
      redirect_to users.path
    else
      flash.now[:danger] = "アカウントの作成に失敗しました。"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
