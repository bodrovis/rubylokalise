# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Branch < Base
      MAIN_PARAMS = %i[project_id branch_id].freeze

      # Merges the current branch with another branch
      #
      # @see https://developers.lokalise.com/reference/merge-a-branch
      # @param params [Hash]
      # @return [RubyLokaliseApi::Generics::MergedBranches]
      def merge(req_params)
        params = { query: [@project_id, @branch_id, :merge], req: req_params }
        response = endpoint(name: 'Branches', client: @self_endpoint.client, params: params).do_post

        RubyLokaliseApi::Generics::MergedBranches.new response[:content]
      end
    end
  end
end
