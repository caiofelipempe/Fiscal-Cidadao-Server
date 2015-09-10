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

      resource :token do

        desc "Register of a new user"
        params do
          requires :grant_type, type: String, desc: ""
          requires :login, type: String, desc: "Email address or login"
          requires :password, type: String, desc: "Password"
        end
        post do
          
        end

      end

    end
  end
end
