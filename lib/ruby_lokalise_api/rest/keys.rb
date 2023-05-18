# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Keys
      # Returns a single translation key
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-key
      # @return [RubyLokaliseApi::Resources::Key]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param req_params[Hash]
      def key(project_id, key_id, req_params = {})
        params = { query: [project_id, key_id], req: req_params }

        data = endpoint(name: 'Keys', params: params).do_get

        resource 'Key', data
      end

      # Returns project translation keys
      #
      # @see https://developers.lokalise.com/reference/list-all-keys
      # @return [RubyLokaliseApi::Collections::Keys]
      # @param project_id [String]
      # @param req_params [Hash]
      def keys(project_id, req_params = {})
        name = 'Keys'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end
    end
  end
end
