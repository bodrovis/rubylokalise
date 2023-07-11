# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class BranchesEndpoint < MainEndpoint
      private

      def base_query(project_id, branch_id = nil)
        {
          projects: project_id,
          branches: branch_id
        }
      end
    end
  end
end
