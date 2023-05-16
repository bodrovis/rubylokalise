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

      # Uploads translation file to the project in the background
      #
      # @see https://developers.lokalise.com/reference/upload-a-file
      # @return [RubyLokaliseApi::Resources::QueuedProcess]
      # @param project_id [String]
      # @param req_params [Hash]
      def upload_file(project_id, req_params)
        files_ep = endpoint 'Files', self, query: [project_id, :upload], req: req_params

        response = files_ep.do_post

        process_id = response.dig(:content, 'process', 'process_id')

        process_ep = endpoint 'QueuedProcesses', self, query: [project_id, process_id]

        response[:endpoint] = process_ep

        resource 'QueuedProcess', response
      end

      # Downloads translation files from the project
      #
      # @see https://developers.lokalise.com/reference/download-files
      # @return [RubyLokaliseApi::Generics::DownloadBundle]
      # @param project_id [String]
      # @param req_params [Hash]
      def download_files(project_id, req_params)
        ep = endpoint 'Files', self, query: [project_id, :download], req: req_params

        RubyLokaliseApi::Generics::DownloadBundle.new ep.do_post[:content]
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
