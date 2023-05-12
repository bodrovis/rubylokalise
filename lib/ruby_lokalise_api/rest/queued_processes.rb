# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module QueuedProcesses
      # Returns a single queued process
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-process
      # @return [RubyLokaliseApi::Resources::QueuedProcess]
      # @param project_id [String]
      # @param process_id [String, Integer]
      def queued_process(project_id, process_id)
        endpoint_resource names: { endpoint: 'QueuedProcesses', resource: 'QueuedProcess' },
                          params: { query: [project_id, process_id] }
      end

      # Returns queued processes
      #
      # @see https://developers.lokalise.com/reference/list-all-processes
      # @return [RubyLokaliseApi::Collections::QueuedProcesses]
      # @param project_id [String]
      # @param req_params [Hash]
      def queued_processes(project_id, req_params = {})
        endpoint_collection names: { endpoint: 'QueuedProcesses', collection: 'QueuedProcesses' },
                            params: { query: project_id, req: req_params }
      end
    end
  end
end
