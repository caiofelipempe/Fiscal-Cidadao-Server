require 'doorkeeper/grape/helpers'

module API
  module V1
    class UserApi < Grape::API
      include Defaults

      error_formatter :json, lambda { |message, backtrace, option, env|
        {
          status: 'failed',
          message: message,
          status_code: env['api.endpoint'].status
        }
      }

      helpers Doorkeeper::Grape::Helpers

      helpers do
        def current_user
          user = User.find(doorkeeper_token.resource_owner_id)
          user
        end
      end

      resource :user do

        desc "Register of a new user"
        params do
          requires :login, type: String, desc: "Username"
          requires :email, type: String, desc: "Email address"
          requires :password, type: String, desc: "Password"
        end
        post :new do
          user = User.new(login: params[:login], email: params[:email], password: params[:password])
          if user.save
            {
              status: 'success'
            }
          else
            raise StandardError.new user.errors.messages
          end
        end

        before do
          doorkeeper_authorize!
          @current_user = current_user
        end

        desc "User with token."
        get do
          {
            id: @current_user.id,
            login: @current_user.login,
            email: @current_user.email,
            image_url: @current_user.image.url
          }
        end

        desc "Update image"
        # params do
        #   requires :image, :type => Rack::Multipart::UploadedFile, :desc => "Image file."
        # end
        post :image do
          encoded_picture = params[:image]
          content_type = "image/jpeg"
          filename =  @current_user.login + ".jpg"
          image = Paperclip.io_adapters.for("data:#{content_type};base64,#{encoded_picture}")
          image.original_filename = filename
          @current_user.image = image
          if @current_user.save
            {
              status: 'success'
            }
          else
            raise StandardError.new @current_user.errors.messages
          end
        end

      end

    end
  end
end
