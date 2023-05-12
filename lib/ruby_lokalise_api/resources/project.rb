# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Project < Base
      MAIN_PARAMS = :project_id

      # Empties the current project by removing all keys and translations
      #
      # @see https://developers.lokalise.com/reference/empty-a-project
      # @return [RubyLokaliseApi::Generics::EmptiedResource]
      def empty
        ep = endpoint 'Projects', @self_endpoint.client, query: [@project_id, :empty]

        RubyLokaliseApi::Generics::EmptiedResource.new ep.do_put[:content]
      end

      # Fetches a key comment within the current project
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-comment
      # @return [RubyLokaliseApi::Resources::Comment]
      def key_comment(key_id, comment_id)
        endpoint_resource(
          names: { endpoint: 'KeyComments', resource: 'Comment' },
          params: { query: [@project_id, key_id, comment_id] },
          client: @self_endpoint.client
        )
      end
    end
  end
end
