# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class BaseResource
      include RubyLokaliseApi::Utils::Loaders

      def initialize(raw_response)
        @content = raw_response[:content]
        @endpoint = raw_response[:endpoint]
      end

      private

      def with_client(&block)
        return unless block

        @endpoint.client.instance_exec(@content, &block)
      end
    end
  end
end
