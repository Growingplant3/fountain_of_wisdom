class Admin::UsersController < ApplicationController
  include SessionsHelper
  before_action :set_user, only: %i[show edit update destroy]
  before_action :check_admin_params

  def index
    @users = User.preload(:tasks).all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "アカウントの作成に成功しました。"
      redirect_to admin_user_path(@user)
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
      redirect_to admin_user_path(@user)
    else
      flash.now[:danger] = "アカウントの編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:danger] = "アカウントを削除しました。"
      redirect_to admin_users_path
    else
      flash[:danger] = "アカウントを削除できませんでした。"
      redirect_to admin_users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_admin_params
    return if current_user.admin == "admin"
    flash[:danger] = "管理者権限がありません。"
    redirect_to tasks_path
  end
end
