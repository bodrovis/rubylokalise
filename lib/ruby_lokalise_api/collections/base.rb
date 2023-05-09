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
                  :collection, :content

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

        resources_data = raw_response[:content][data_key_plural]
        other_data = raw_response[:content].reject { |key, _| key == data_key_plural }

        @collection = build_collection resources_data, other_data
      end

      def build_collection(resources_data, other_data)
        resources_data.map do |raw_resource|
          self.class.const_get(:RESOURCE).new(resource_data(raw_resource, other_data))
        end
      end

      def resource_data(raw_resource, other_data)
        {
          content: raw_resource.merge(other_data),
          endpoint: resource_endpoint.new(
            @endpoint.client,
            query: query_for(raw_resource, other_data)
          )
        }
      end

      def query_for(raw_resource, other_data)
        main_params = self.class.const_get(:RESOURCE).const_get(:MAIN_PARAMS).to_array

        main_params.map do |param|
          other_data[param] || raw_resource[param] || nil
        end
      end

      def resource_endpoint
        if self.class.const_defined?(:RESOURCES_ENDPOINT)
          self.class.const_get(:RESOURCES_ENDPOINT)
        else
          self.class.const_get(:ENDPOINT)
        end
      end
    end
  end
end
