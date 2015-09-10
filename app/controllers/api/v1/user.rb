require 'doorkeeper/grape/helpers'

module API
  module V1
    class User < Grape::API
      include Defaults

      error_formatter :json, lambda { |message, backtrace, option, env|
        {
          status: 'failed',
          message: message,
          status_code: env['api.endpoint'].status
        }
      }

      helpers Doorkeeper::Grape::Helpers

      before do
        doorkeeper_authorize!
      end

      resource :user do

        desc "Register of a new user"
        params do
          requires :login, type: String, desc: "Username"
          requires :email, type: String, desc: "Email address"
          requires :password, type: String, desc: "Password"
        end
        post :new do
          user = user.new(login: params[:login], email: params[:email], password: params[:password])
          if user.save
            {
              status: 'success'
            }
          else
            raise StandardError.new user.errors
          end
        end

        desc "User with token."
        get do
          {
            status: 'success'
          }
        end

      end

    end
  end
end
