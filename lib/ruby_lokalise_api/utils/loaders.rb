# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Loaders
      private

      def endpoint_resource(names:, params: {}, verb: :get, client: self)
        ep = endpoint(names[:endpoint], client, params)

        resource names[:resource], ep.send("do_#{verb}".to_sym)
      end

      def endpoint_collection(names:, params: {}, verb: :get, client: self)
        ep = endpoint(names[:endpoint], client, params)

        collection names[:collection], ep.send("do_#{verb}".to_sym)
      end

      def endpoint_delete(endpoint:, params: {}, client: self)
        ep = endpoint(endpoint, client, params)

        RubyLokaliseApi::Generics::DeletedResource.new ep.do_delete[:content]
      end

      def endpoint(name, client, params = {})
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
