module API
  module V1
    class IssueApi < Grape::API
      include Defaults

      helpers do
      end

      resource :issues do

        desc "List of issues."
        get do
          Issue.all
        end

      end
    end
  end
end
