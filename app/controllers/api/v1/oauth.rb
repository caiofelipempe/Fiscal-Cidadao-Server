module API
  module V1
    class Oauth < Grape::API
      include Defaults

      error_formatter :json, lambda { |message, backtrace, option, env|
        {
          status: 'failed',
          message: message,
          status_code: env['api.endpoint'].status
        }
      }

      helpers do

      end

      resource :oauth do

        desc "Register of a new user"
        params do
          requires :grant_type, type: String, desc: ""
          requires :login, type: String, desc: "Email address or login"
          requires :password, type: String, desc: "Password"
        end
        post :token do
          if params[:login].include?("@")
            user = User.find_by_email(params[:login].downcase)
          else
            user = User.find_by_login(params[:login].downcase)
          end

          if user && user.valid_password?(params[:password])
            # Create a token to user.
          else
            error!('Unauthorized.', 401)
          end
        end

      end

    end
  end
end
