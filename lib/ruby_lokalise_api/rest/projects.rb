# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Projects
      # Returns a single project
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-project
      # @return [RubyLokaliseApi::Resources::Project]
      # @param project_id [String]
      def project(project_id)
        endpoint_resource names: { endpoint: 'Projects', resource: 'Project' },
                          params: { query: project_id }
      end

      # Returns a collection of projects
      #
      # @see https://developers.lokalise.com/reference/list-all-projects
      # @return [RubyLokaliseApi::Collections::Projects]
      # @param req_params [Hash]
      def projects(req_params = {})
        endpoint_collection names: { endpoint: 'Projects', collection: 'Projects' },
                            params: { req: req_params }
      end

      # Creates a project
      #
      # @see https://developers.lokalise.com/reference/create-a-project
      # @return [RubyLokaliseApi::Resources::Project]
      # @param req_params [Hash]
      def create_project(req_params)
        endpoint_resource names: { endpoint: 'Projects', resource: 'Project' },
                          params: { req: req_params },
                          verb: :post
      end

      # Updates a project
      #
      # @see https://developers.lokalise.com/reference/update-a-project
      # @return [RubyLokaliseApi::Resources::Project]
      # @param project_id [String]
      # @param req_params [Hash]
      def update_project(project_id, req_params)
        endpoint_resource names: { endpoint: 'Projects', resource: 'Project' },
                          params: { query: project_id, req: req_params },
                          verb: :put
      end

      # Deletes a project
      #
      # @see https://developers.lokalise.com/reference/delete-a-project
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      def destroy_project(project_id)
        endpoint_delete endpoint: 'Projects',
                        params: { query: project_id }
      end

      # Empties a project by deleting all keys and translations
      #
      # @see https://developers.lokalise.com/reference/empty-a-project
      # @return [RubyLokaliseApi::Generics::EmptiedResource]
      # @param project_id [String]
      def empty_project(project_id)
        ep = endpoint 'Projects', self, query: [project_id, :empty]

        RubyLokaliseApi::Generics::EmptiedResource.new ep.do_put[:content]
      end
    end
  end
end
