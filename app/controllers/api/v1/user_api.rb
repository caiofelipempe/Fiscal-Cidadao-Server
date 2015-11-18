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

        def creation_time(created_at)
          creation_time = (Time.now - created_at)
          if creation_time < 60
            creation_time = "Agora"
          else
            creation_time = creation_time/60
            if creation_time < 60
              creation_time = creation_time.round
              if creation_time > 1
                creation_time = creation_time.to_s + " Minutos"
              else
                creation_time = creation_time.to_s + " Minuto"
              end
            else
              creation_time = creation_time/60
              if creation_time < 60
                creation_time = creation_time.round
                if creation_time > 1
                  creation_time = creation_time.to_s + " Horas"
                else
                  creation_time = creation_time.to_s + " Hora"
                end
              else
                creation_time = creation_time/24
                creation_time = creation_time.round
                if creation_time > 1
                  creation_time = creation_time.to_s + " Dias"
                else
                  creation_time = creation_time.to_s + " Dia"
                end
              end
            end
          end
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

        desc "List of issues."
        get :issues do
          Issue.all
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
            email: @current_user.email
          }
        end

        desc "Report a issue."
        params do
          requires :latitude, type: Float, desc: "Latitude"
          requires :longitude, type: Float, desc: "Longitude"
          optional :address, type: String, desc: "Address"
          optional :issue_id, type: Integer, desc: "id of issue"
          requires :description, type: String, desc: "Description"
        end
        post :issue_report do
          # issue = Issue.find(params[:issue_id])
          # if !issue
          #   raise StandardError.new "Issue id is not registered."
          # end

          issue_report = IssueReport.new(
            user: @current_user,
            issue_id: params[:issue_id],
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

        desc "Get report problems."
        get :solved_issue_reports do
          array = []
          IssueReport.all.each do |issue_report|
            if resolution_report = issue_report.resolution_report
              array << {
                id: issue_report.id,
                user: User.find(issue_report.user_id),
                issue: issue_report.issue,
                description: issue_report.description,
                latitude: issue_report.latitude,
                longitude: issue_report.longitude,
                address: issue_report.address,
                image_url: issue_report.image.url(:thumb),
                creation_time: creation_time(issue_report.created_at),
                resolution_report: {
                  id: resolution_report.id,
                  description: resolution_report.description,
                  creation_time: creation_time(resolution_report.created_at)
                }
              }
            end
          end
          array
        end

        before do
          if current_user.admin == nil
            raise StandardError.new 'Access denied.'
          end
        end

        desc "Create new issue."
        params do
          requires :name, type: Float, desc: "Name of new issue"
        end
        post :issue do
          issue = Issue.new(name: params[:name])
          if issue.save
            {
              status: 'success'
            }
          else
            raise StandardError.new issue.errors.messages
          end
        end

        desc "Update new issue."
        params do
          requires :id, type: Float, desc: "Id of new issue"
          requires :name, type: Float, desc: "New name of issue"
        end
        patch :issue do
          issue = Issue.find(id: params[:id])
          issue.name = params[:name]
          if issue.save
            {
              status: 'success'
            }
          else
            raise StandardError.new issue.errors.messages
          end
        end

        desc "delete issue."
        params do
          requires :id, type: Float, desc: "Name of new issue"
        end
        delete :issue do
          issue = Issue.find(id: params[:id])
          if issue.delete
            {
              status: 'success'
            }
          else
            raise StandardError.new issue.errors.messages
          end
        end

        desc "Get report problems."
        get :issue_reports do
          array = []
          IssueReport.all.each do |issue_report|
            array << {
              id: issue_report.id,
              user: User.find(issue_report.user_id),
              issue: issue_report.issue,
              description: issue_report.description,
              latitude: issue_report.latitude,
              longitude: issue_report.longitude,
              address: issue_report.address,
              image_url: issue_report.image.url(:thumb),
              creation_time: creation_time(issue_report.created_at)
            }
          end
          array
        end

      end

    end
  end
end
