module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        version 'v1', using: :header, vendor: 'cidadao_alerta'
        format :json
        rescue_from :all
        prefix :api
      end

    end
  end
end
