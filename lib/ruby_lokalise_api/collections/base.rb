# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Base
      using RubyLokaliseApi::Utils::Classes
      include RubyLokaliseApi::Utils::Keys

      attr_reader :total_pages, :total_results, :results_per_page, :current_page,
                  :collection

      def initialize(raw_response)
        @endpoint = raw_response[:endpoint]

        populate_pagination_from raw_response
        produce_collection_from raw_response

        # @content = raw_response[:content]
      end

      private

      def populate_pagination_from(raw_response)
        @total_results = raw_response[:'x-pagination-total-count'].to_i
        @total_pages = raw_response[:'x-pagination-page-count'].to_i
        @results_per_page = raw_response[:'x-pagination-limit'].to_i
        @current_page = raw_response[:'x-pagination-page'].to_i
      end

      def produce_collection_from(raw_response)
        return unless raw_response[:content]

        klass = self.class.base_name
        data_key_plural = collection_key_for klass: klass

        @collection = raw_response[:content][data_key_plural].map do |raw_model|
          Module.const_get(
            "RubyLokaliseApi::Resources::#{klass}"
          ).new(model_data(raw_model))
        end
      end

      def model_data(raw_model)
        {
          content: raw_model,
          endpoint: self.class.const_get(:ENDPOINT).new(
            @endpoint.client,
            query: [
              raw_model[self.class.const_get(:MAIN_PARAM).to_s]
            ]
          )
        }
      end
    end
  end
end
