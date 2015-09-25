module ApplicationHelper
  def authenticate_admin?
    if current_user != nil && current_user.admin_id != nil
      true
    else
      false
    end
  end
end
