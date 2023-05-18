# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Base
      using RubyLokaliseApi::Utils::Classes
      extend RubyLokaliseApi::Utils::Attributes
      extend RubyLokaliseApi::Concerns::Unsupportable
      extend RubyLokaliseApi::Concerns::AttrsLoadable
      include RubyLokaliseApi::Concerns::HashAccessible
      include RubyLokaliseApi::Utils::Loaders
      include RubyLokaliseApi::Utils::Keys

      ATTRS_FILENAME = 'resource_attributes.yml'

      def initialize(raw_response)
        @self_endpoint = raw_response[:endpoint]

        populate_attrs_from raw_response[:content]

        # @raw_content = raw_response[:content]
      end

      # Updates the current resource
      def update(params)
        self.class.new reinit_endpoint(params).do_put
      end

      # Deletes the current resource
      def destroy
        RubyLokaliseApi::Generics::DeletedResource.new(
          reinit_endpoint.do_delete[:content]
        )
      end

      # Reloads the current resource with new values from the API
      def reload_data
        self.class.new reinit_endpoint.do_get
      end

      private

      def reinit_endpoint(req_params = {})
        query_params = self.class.const_get(:MAIN_PARAMS).to_array.map do |param|
          instance_variable_get "@#{param}"
        end

        @self_endpoint.reinitialize(query_params: query_params, req_params: req_params)
      end

      def populate_attrs_from(content)
        return unless content

        data_key = data_key_for klass: self.class.base_name

        supported_attrs.each do |attrib|
          value = if content.key?(data_key) && content[data_key].is_a?(Hash) && content[data_key].key?(attrib)
                    content[data_key][attrib]
                  else
                    content[attrib]
                  end

          instance_variable_set "@#{attrib}", value
        end
      end
    end
  end
end
