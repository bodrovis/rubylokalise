# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    module Main
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
end
