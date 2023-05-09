# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module CustomTranslationStatuses
      # Returns a custom translation status
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-status
      # @return [RubyLokaliseApi::Resources::CustomTranslationStatus]
      # @param project_id [String]
      # @param status_id [String, Integer]
      def custom_translation_status(project_id, status_id)
        endpoint_resource names: { endpoint: 'CustomTranslationStatuses', resource: 'CustomTranslationStatus' },
                          params: { query: [project_id, status_id] }
      end

      # Returns custom translation statuses for the project
      #
      # @see https://developers.lokalise.com/reference/list-all-statuses
      # @return [RubyLokaliseApi::Collections::CustomTranslationStatuses]
      # @param project_id [String]
      # @param req_params [Hash]
      def custom_translation_statuses(project_id, req_params = {})
        endpoint_collection names: { endpoint: 'CustomTranslationStatuses', collection: 'CustomTranslationStatuses' },
                            params: { query: project_id, req: req_params }
      end
    end
  end
end
