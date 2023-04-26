# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Loaders
      private

      def main_endpoint_res(names:, params: {}, verb: :get, client: self)
        ep = endpoint("Main::#{names[:endpoint]}", params, client)

        resource names[:resource], ep.send("do_#{verb}".to_sym)
      end

      def main_endpoint_collection(names:, params: {}, verb: :get, client: self)
        ep = endpoint("Main::#{names[:endpoint]}", params, client)

        collection names[:collection], ep.send("do_#{verb}".to_sym)
      end

      def main_endpoint_delete(endpoint:, params: {}, client: self)
        ep = endpoint("Main::#{endpoint}", params, client)

        RubyLokaliseApi::Types::DeletedResource.new ep.do_delete[:content]
      end

      def endpoint(name, params, client)
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
    end
  end
end
