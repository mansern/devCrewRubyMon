module ApplicationHelper
  def user_name
    current_user.name.blank? ? current_user.email : current_user.name
  end
end
