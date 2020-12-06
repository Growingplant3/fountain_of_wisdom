class SessionsController < ApplicationController
  def new
  end

  def create
    binding.pry
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "ログインに成功しました。"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "ログインに失敗しました。"
      render :new
    end  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "ログアウトしました。"
    redirect_to new_session_path
  end
end