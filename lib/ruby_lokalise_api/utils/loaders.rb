# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Loaders
      private

      def endpoint(name:, client: self, params: {})
        klass = RubyLokaliseApi.const_get "Endpoints::#{name}Endpoint"
        klass.new client, params
      end

      def resource(name, data)
        klass = RubyLokaliseApi.const_get "Resources::#{name}"
        klass.new data
      end

      def collection(name, data)
        klass = RubyLokaliseApi.const_get "Collections::#{name}"
        klass.new data
      end

      def patch_content_with(data, attribute, value)
        data[:content][attribute] = value
        data
      end

      def patch_endpoint_with(data, ep_name, params)
        data[:endpoint] = endpoint(name: ep_name, params: params)
        data
      end
    end
  end
end
