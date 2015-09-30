module ApplicationHelper
  def authenticate_admin?
    if current_user != nil && current_user.admin != nil
      true
    else
      false
    end
  end
end
