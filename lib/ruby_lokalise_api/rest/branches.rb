# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Branches
      # Returns project branches
      #
      # @see https://developers.lokalise.com/reference/list-all-branches
      # @return [RubyLokaliseApi::Collections::Branches]
      # @param project_id [String]
      # @param req_params [Hash]
      def branches(project_id, req_params = {})
        name = 'Branches'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns a single branch
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-branch
      # @return [RubyLokaliseApi::Resources::Branch]
      # @param project_id [String]
      # @param branch_id [String, Integer]
      def branch(project_id, branch_id)
        params = { query: [project_id, branch_id] }

        data = endpoint(name: 'Branches', params: params).do_get

        resource 'Branch', data
      end

      # Creates a branch
      #
      # @see https://developers.lokalise.com/reference/create-a-branch
      # @return [RubyLokaliseApi::Resources::Branch]
      # @param project_id [String]
      # @param req_params [Hash]
      def create_branch(project_id, req_params)
        params = { query: project_id, req: req_params }

        data = endpoint(name: 'Branches', params: params).do_post

        resource 'Branch', data
      end
    end
  end
end
