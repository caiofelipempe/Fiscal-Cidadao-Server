Doorkeeper.configure do
  resource_owner_from_credentials do |routes|
    if params[:username].include?("@")
          user = User.find_by_email(params[:username].downcase)
        else
          user = User.find_by_login(params[:username])
        end
    if user && user.valid_for_authentication? { user.valid_password?(params[:password]) }
      user
    end
  end
end

Doorkeeper.configuration.token_grant_types << "password"
