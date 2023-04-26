# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Projects
      # Returns a single project
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-project
      # @return [RubyLokaliseApi::Resources::Project]
      # @param project_id [String, Integer]
      def project(project_id)
        main_endpoint_res names: { endpoint: 'Projects', resource: 'Project' },
                          params: { query: [project_id] }
      end

      def projects(req_params = {})
        main_endpoint_collection names: { endpoint: 'Projects', collection: 'Project' },
                                 params: { req: req_params }
      end

      def create_project(req_params)
        # validation = RubyLokaliseApi::Contracts::NewProjectContract.new.call(req_params)

        # return validation.errors unless validation.success?

        main_endpoint_res names: { endpoint: 'Projects', resource: 'Project' },
                          params: { req: req_params },
                          verb: :post
      end

      def destroy_project(project_id)
        main_endpoint_delete endpoint: 'Projects',
                             params: { query: [project_id] }
      end
    end
  end
end
