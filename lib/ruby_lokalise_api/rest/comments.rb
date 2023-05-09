# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Comments
      # Returns a single key comment
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-comment
      # @return [RubyLokaliseApi::Resources::Comment]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param comment_id [String, Integer]
      def comment(project_id, key_id, comment_id)
        endpoint_resource names: { endpoint: 'KeyComments', resource: 'Comment' },
                          params: { query: [project_id, key_id, comment_id] }
      end

      # Returns all comments for a key
      #
      # @see https://developers.lokalise.com/reference/list-key-comments
      # @return [RubyLokaliseApi::Collections::KeyComments]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param req_params [Hash]
      def comments(project_id, key_id, req_params = {})
        endpoint_collection names: { endpoint: 'KeyComments', collection: 'KeyComments' },
                            params: { query: [project_id, key_id], req: req_params }
      end

      # Returns all comments for a project
      #
      # @see https://developers.lokalise.com/reference/list-project-comments
      # @return [RubyLokaliseApi::Collections::ProjectComments]
      # @param project_id [String]
      # @param req_params [Hash]
      def project_comments(project_id, req_params = {})
        endpoint_collection names: { endpoint: 'ProjectComments', collection: 'ProjectComments' },
                            params: { query: [project_id], req: req_params }
      end

      # Creates one or multiple comments for a key
      #
      # @see https://developers.lokalise.com/reference/create-comments
      # @return [RubyLokaliseApi::Collections::KeyComments]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param req_params [Hash, Array]
      def create_comments(project_id, key_id, req_params)
        endpoint_collection names: { endpoint: 'KeyComments', collection: 'KeyComments' },
                            params: { query: [project_id, key_id], req: to_comments_obj(req_params) },
                            verb: :post
      end

      # Deletes a single key comment
      #
      # @see https://developers.lokalise.com/reference/delete-a-comment
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param comment_id [String, Integer]
      def destroy_comment(project_id, key_id, comment_id)
        endpoint_delete endpoint: 'KeyComments',
                        params: { query: [project_id, key_id, comment_id] }
      end

      private

      def to_comments_obj(raw_data)
        raw_data = [raw_data] unless raw_data.is_a?(Array)

        { comments: raw_data }
      end
    end
  end
end
