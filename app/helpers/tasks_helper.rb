module TasksHelper
  def change_root
    case action_name
    when "new"
      tasks_path
    when "edit"
      task_path
    end
  end
end
