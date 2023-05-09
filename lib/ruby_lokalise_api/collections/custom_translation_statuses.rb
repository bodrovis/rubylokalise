# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class CustomTranslationStatuses < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::CustomTranslationStatusesEndpoint
      RESOURCE = RubyLokaliseApi::Resources::CustomTranslationStatus
      # DATA_KEY = 'custom_translation_statuses'
    end
  end
end
