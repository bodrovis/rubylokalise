# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Loaders
      private

      def main_endpoint_load(names:, params: {}, verb: :get, client: self)
        ep = endpoint("Main::#{names[:endpoint]}", params, client)

        resource names[:resource], ep.send("do_#{verb}".to_sym)
      end

      def endpoint(name, params, client)
        klass = RubyLokaliseApi.const_get "Endpoints::#{name}Endpoint"
        klass.new client, params
      end

      def resource(name, data)
        klass = RubyLokaliseApi.const_get "Resources::#{name}Resource"
        klass.new data
      end
    end
  end
end
