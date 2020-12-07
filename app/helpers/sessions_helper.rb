module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def sign_in_check
    if logged_in?
      case action_name
      when "show","edit","update","destroy"
        if session[:user_id] != current_user.id
          flash[:danger] = "他人のデータを扱うことはできません"
          redirect_to tasks_path
        end
      end
    else
      flash[:danger] = "ログインする必要があります"
      redirect_to new_session_path
    end
  end

  def logged_in_user_can_not_log_in
    redirect_back(fallback_location: tasks_path) if session[:user_id]
  end
end
