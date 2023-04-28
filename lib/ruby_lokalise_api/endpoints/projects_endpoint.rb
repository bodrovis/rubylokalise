# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class ProjectsEndpoint < MainEndpoint
      private

      def base_query(project_id = nil)
        {
          projects: project_id
        }
      end
    end
  end
end
