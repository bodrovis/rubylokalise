# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class BaseEndpoint
      using RubyLokaliseApi::Utils::Classes
      include RubyLokaliseApi::Request

      attr_reader :client, :req_params, :uri

      BASE_URL = ''
      PARTIAL_URI_TEMPLATE = '{/segments*}'

      def initialize(client, params = {})
        @query_params = params[:query].to_array
        @client = client
        @req_params = params[:req]
        @uri = partial_uri(base_query(*@query_params), params.fetch(:get, []))
      end

      def reinitialize(query_params: nil, req_params: {})
        @query_params = query_params || @query_params
        @req_params = req_params || @req_params
        @uri = partial_uri(base_query(*@query_params))

        self
      end

      def base_url
        self.class.const_get(:BASE_URL)
      end

      def base_query(*_args)
        {}
      end

      def full_uri
        base_url + uri
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

      def partial_uri(segments, _query = [])
        template = Addressable::Template.new self.class.const_get(:PARTIAL_URI_TEMPLATE)

        template.expand(
          segments: segments.to_a.flatten
        ).to_s
      end
    end
  end
end
