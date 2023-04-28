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
        endpoint_resource names: { endpoint: 'Projects', resource: 'Project' },
                          params: { query: project_id }
      end

      def projects(req_params = {})
        endpoint_collection names: { endpoint: 'Projects', collection: 'Projects' },
                            params: { req: req_params }
      end

      def create_project(req_params)
        # validation = RubyLokaliseApi::Contracts::NewProjectContract.new.call(req_params)

        # return validation.errors unless validation.success?

        endpoint_resource names: { endpoint: 'Projects', resource: 'Project' },
                          params: { req: req_params },
                          verb: :post
      end

      def destroy_project(project_id)
        endpoint_delete endpoint: 'Projects',
                        params: { query: project_id }
      end
    end
  end
end
