module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        version 'v1', using: :header, vendor: 'cidadao_alerta'
        format :json
        rescue_from :all
        prefix :api

        error_formatter :json, lambda { |message, backtrace, option, env|
          {
            status: 'failed',
            message: message,
            status_code: env['api.endpoint'].status
          }.to_json
        }
      end

    end
  end
end
