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

      # Creates a custom translation status
      #
      # @see https://developers.lokalise.com/reference/create-a-status
      # @return [RubyLokaliseApi::Resources::CustomTranslationStatus]
      # @param project_id [String]
      # @param req_params [Hash]
      def create_custom_translation_status(project_id, req_params)
        endpoint_resource names: { endpoint: 'CustomTranslationStatuses', resource: 'CustomTranslationStatus' },
                          params: { query: project_id, req: req_params },
                          verb: :post
      end

      # Updates a custom translation status
      #
      # @see https://developers.lokalise.com/reference/update-a-status
      # @return [RubyLokaliseApi::Resources::CustomTranslationStatus]
      # @param project_id [String]
      # @param status_id [Integer, String]
      # @param req_params [Hash]
      def update_custom_translation_status(project_id, status_id, req_params = {})
        endpoint_resource names: { endpoint: 'CustomTranslationStatuses', resource: 'CustomTranslationStatus' },
                          params: { query: [project_id, status_id], req: req_params },
                          verb: :put
      end

      # Deletes a custom translation status
      #
      # @see https://developers.lokalise.com/reference/delete-a-status
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param status_id [Integer, String]
      def destroy_custom_translation_status(project_id, status_id)
        endpoint_delete endpoint: 'CustomTranslationStatuses',
                        params: { query: [project_id, status_id] }
      end

      # Retrieves an array of available colors that can be assigned to custom translation statuses
      #
      # @see https://developers.lokalise.com/reference/retrieve-available-colors
      # @return [RubyLokaliseApi::Generics::CustomStatusAvailableColors]
      # @param project_id [String]
      def custom_translation_status_colors(project_id)
        ep = endpoint 'CustomTranslationStatuses', self, { query: [project_id, :colors] }

        RubyLokaliseApi::Generics::CustomStatusAvailableColors.new ep.do_get[:content]
      end
    end
  end
end
