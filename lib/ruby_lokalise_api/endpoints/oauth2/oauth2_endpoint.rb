# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    module OAuth2
      class OAuth2Endpoint < BaseEndpoint
        BASE_URL = 'https://app.lokalise.com/oauth2'
        PARTIAL_URI_TEMPLATE = '{/segments*}{?query*}'

        private

        def partial_uri(segments, query)
          template = Addressable::Template.new PARTIAL_URI_TEMPLATE

          template.expand(
            segments: segments.to_a.flatten,
            query: query.filter { |_k, v| !v.nil? }
          ).to_s
        end

        def base_query(segment = nil)
          [segment]
        end
      end
    end
  end
end
