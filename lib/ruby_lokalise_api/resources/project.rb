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
        params = { query: [@project_id, :empty] }
        response = endpoint(name: 'Projects', client: @self_endpoint.client, params: params).do_put

        RubyLokaliseApi::Generics::EmptiedResource.new response[:content]
      end

      # Fetches a key comment within the current project
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-comment
      # @return [RubyLokaliseApi::Resources::Comment]
      def key_comment(key_id, comment_id)
        params = { query: [@project_id, key_id, comment_id] }

        key_comments = endpoint(name: 'KeyComments', client: @self_endpoint.client, params: params).do_get

        resource 'Comment', key_comments
      end
    end
  end
end
