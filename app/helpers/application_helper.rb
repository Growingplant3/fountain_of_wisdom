module ApplicationHelper
  def change_root
    case action_name
    when "new"
      tasks_path if controller_name == "tasks"
      users_path if controller_name == "users"
    when "edit"
      task_path if controller_name == "tasks"
      user_path if controller_name == "users"
    end
  end
end
