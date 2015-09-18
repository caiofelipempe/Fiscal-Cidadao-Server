require 'doorkeeper/grape/helpers'

module API
  module V1
    class UserApi < Grape::API
      include Defaults

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

        desc "Report a issue."
        params do
          requires :latitude, type: Float, desc: "Latitude"
          requires :longitude, type: Float, desc: "Longitude"
          optional :address, type: String, desc: "Address"
          requires :issue_id, type: Integer, desc: "id of issue"
          requires :description, type: String, desc: "Description"
        end
        post :issue do
          issue = Issue.find(params[:issue_id])
          if !issue
            raise StandardError.new "Issue id is not registered."
          end

          issue_report = IssueReport.new(
            user: @current_user,
            issue_id: issue.id,
            latitude: params[:latitude],
            longitude: params[:longitude],
            description: params[:description]
          )

          address = params[:address]
          if address
            issue_report.address = address
          else

          end

          encoded_picture = params[:image]
          if encoded_picture
            content_type = "image/jpeg"
            filename =  issue_report.id.to_s + "issue_report_image.jpg"
            image = Paperclip.io_adapters.for("data:#{content_type};base64,#{encoded_picture}")
            image.original_filename = filename
            issue_report.image = image
          end

          if issue_report.save
            {
              status: 'success'
            }
          else
            raise StandardError.new issue_report.errors.messages
          end
        end

      end

    end
  end
end
