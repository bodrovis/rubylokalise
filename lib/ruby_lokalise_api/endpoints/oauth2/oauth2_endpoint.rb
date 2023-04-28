module RubyLokaliseApi
  module Endpoints
    module OAuth2
      class OAuth2Endpoint < BaseEndpoint
        include RubyLokaliseApi::Request

        BASE_URL = 'https://app.lokalise.com/oauth2'

        private

        def base_query(fragment = nil)
          [ fragment ]
        end
      end
    end
  end
end