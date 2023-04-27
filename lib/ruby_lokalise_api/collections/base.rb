# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Base
      include Enumerable
      extend Forwardable

      using RubyLokaliseApi::Utils::Classes
      include RubyLokaliseApi::Utils::Keys

      def_delegators :collection, :[], :last, :each

      attr_reader :total_pages, :total_results, :results_per_page, :current_page,
                  :collection

      def initialize(raw_response)
        @endpoint = raw_response[:endpoint]

        populate_pagination_from raw_response
        produce_collection_from raw_response

        @content = raw_response[:content]
      end

      def next_page
        return nil if last_page?

        self.class.new(
          reinit_endpoint(
            override_req_params: { page: @current_page + 1 }
          ).do_get
        )
      end

      def prev_page
        return nil if first_page?

        self.class.new(
          reinit_endpoint(
            override_req_params: { page: @current_page - 1 }
          ).do_get
        )
      end

      def next_page?
        @current_page.positive? && @current_page < @total_pages
      end

      def last_page?
        !next_page?
      end

      def prev_page?
        @current_page > 1
      end

      def first_page?
        !prev_page?
      end

      private

      def reinit_endpoint(req_params: @endpoint.req_params, override_req_params: {})
        @endpoint.reinitialize(
          req_params: req_params.merge(override_req_params)
        )
      end

      def populate_pagination_from(raw_response)
        @total_results = raw_response[:'x-pagination-total-count'].to_i
        @total_pages = raw_response[:'x-pagination-page-count'].to_i
        @results_per_page = raw_response[:'x-pagination-limit'].to_i
        @current_page = raw_response[:'x-pagination-page'].to_i
      end

      def produce_collection_from(raw_response)
        return unless raw_response[:content]

        data_key_plural = collection_key_for klass: self.class.base_name

        model_data = raw_response[:content][data_key_plural]
        other_data = raw_response[:content].reject { |key, _| key == data_key_plural }

        @collection = build_collection model_data, other_data
      end

      def build_collection(model_data, other_data)
        model_data.map do |raw_model|
          self.class.const_get(:RESOURCE).new(model_data(raw_model, other_data))
        end
      end

      def model_data(raw_model, other_data)
        {
          content: raw_model.merge(other_data),
          endpoint: self.class.const_get(:ENDPOINT).new(
            @endpoint.client,
            query: query_for(raw_model, other_data)
          )
        }
      end

      def query_for(raw_model, other_data)
        main_params = self.class.const_get(:RESOURCE).const_get(:MAIN_PARAMS).to_array

        main_params.map do |param|
          other_data[param] || raw_model[param] || nil
        end
      end
    end
  end
end
