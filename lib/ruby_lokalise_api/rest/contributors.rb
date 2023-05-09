# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Contributors
      # Returns a single contributor
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-contributor
      # @return [RubyLokaliseApi::Resources::Contributor]
      # @param project_id [String]
      # @param contributor_id [String, Integer]
      def contributor(project_id, contributor_id)
        endpoint_resource names: { endpoint: 'Contributors', resource: 'Contributor' },
                          params: { query: [project_id, contributor_id] }
      end

      # Returns project contributors
      #
      # @see https://developers.lokalise.com/reference/list-all-contributors
      # @return [RubyLokaliseApi::Collections::Contributors]
      # @param project_id [String]
      # @param req_params [Hash]
      def contributors(project_id, req_params = {})
        endpoint_collection names: { endpoint: 'Contributors', collection: 'Contributors' },
                            params: { query: project_id, req: req_params }
      end

      # Creates one or multiple contributors for a project
      #
      # @see https://developers.lokalise.com/reference/create-contributors
      # @return [RubyLokaliseApi::Collections::Contributors]
      # @param project_id [String]
      # @param req_params [Hash, Array]
      def create_contributors(project_id, req_params)
        endpoint_collection names: { endpoint: 'Contributors', collection: 'Contributors' },
                            params: { query: project_id, req: to_contributors_obj(req_params) },
                            verb: :post
      end

      # Updates a contributor for a project
      #
      # @see https://developers.lokalise.com/reference/update-a-contributor
      # @return [RubyLokaliseApi::Resources::Contributor]
      # @param project_id [String]
      # @param contributor_id [String, Integer]
      # @param req_params [Hash]
      def update_contributor(project_id, contributor_id, req_params)
        endpoint_resource names: { endpoint: 'Contributors', resource: 'Contributor' },
                          params: { query: [project_id, contributor_id], req: req_params },
                          verb: :put
      end

      # Deletes a single contributor from the project
      #
      # @see https://developers.lokalise.com/reference/delete-a-contributor
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param contributor_id [String, Integer]
      def destroy_contributor(project_id, contributor_id)
        endpoint_delete endpoint: 'Contributors',
                        params: { query: [project_id, contributor_id] }
      end

      private

      def to_contributors_obj(raw_data)
        raw_data = [raw_data] unless raw_data.is_a?(Array)

        { contributors: raw_data }
      end
    end
  end
end
