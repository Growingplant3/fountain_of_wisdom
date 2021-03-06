class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :sign_in_check, only: %i[show edit update destroy]
  before_action :logged_in_user_can_not_log_in, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "アカウントを作成後、ログインしました。"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "アカウントの作成に失敗しました。"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "アカウントの編集に成功しました。"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "アカウントの編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = "アカウントを削除しました。"
    redirect_to new_user_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
