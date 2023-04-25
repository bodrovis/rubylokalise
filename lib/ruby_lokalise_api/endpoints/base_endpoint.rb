# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class BaseEndpoint
      attr_reader :client, :req_params, :uri

      BASE_URL = ''

      def initialize(client, params = {})
        @query_params = params[:query]
        @client = client
        @req_params = params[:req]
        @uri = partial_uri(base_query(*@query_params))
      end

      def reinitialize(query_params: nil, req_params: {})
        @query_params = query_params || @query_params
        @req_params = req_params || @req_params
        @uri = partial_uri(base_query(*@query_params))

        self
      end

      def base_url
        self.class::BASE_URL
      end

      private

      HTTP_METHODS_REGEXP = /\Ado_(get|post|put|delete)\z/.freeze

      def respond_to_missing?(method, _include_all)
        return true if HTTP_METHODS_REGEXP.match?(method.to_s)

        super
      end

      def method_missing(method, *_args)
        if method.to_s =~ HTTP_METHODS_REGEXP
          send Regexp.last_match(1), self
        else
          super
        end
      end

      def partial_uri(instance_query)
        template = Addressable::Template.new '{/segments*}'

        template.expand(
          segments: instance_query.to_a.flatten
        ).to_s
      end
    end
  end
end
