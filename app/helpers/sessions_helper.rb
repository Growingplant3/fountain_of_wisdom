module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def sign_in_check
    if logged_in?
      return
    else
      flash[:danger] = "ログインする必要があります"
      redirect_to new_session_path
    end
  end

  def logged_in_user_can_not_log_in
    redirect_back(fallback_location: tasks_path) if session[:user_id]
  end
end
