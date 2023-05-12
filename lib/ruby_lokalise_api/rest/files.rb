# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Files
      # Returns project files
      #
      # @see https://developers.lokalise.com/reference/list-all-files
      # @return [RubyLokaliseApi::Collections::Files]
      # @param project_id [String]
      # @param req_params [Hash]
      def files(project_id, req_params = {})
        endpoint_collection names: { endpoint: 'Files', collection: 'Files' },
                            params: { query: project_id, req: req_params }
      end

      # Deletes a single file from the project.
      # Only the "Documents" projects are supported
      #
      # @see https://developers.lokalise.com/reference/delete-a-file
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param file_id [String, Integer]
      def destroy_file(project_id, file_id)
        endpoint_delete endpoint: 'Files',
                        params: { query: [project_id, file_id] }
      end
    end
  end
end
