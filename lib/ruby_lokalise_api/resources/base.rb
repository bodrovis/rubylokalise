# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Base
      using RubyLokaliseApi::Utils::Classes
      include RubyLokaliseApi::Concerns::HashAccessible
      extend RubyLokaliseApi::Utils::Attributes
      include RubyLokaliseApi::Utils::Loaders
      include RubyLokaliseApi::Utils::Keys

      def initialize(raw_response)
        @endpoint = raw_response[:endpoint]

        populate_attrs_from raw_response[:content]

        # @raw_content = raw_response[:content]
      end

      def update(params)
        self.class.new reinit_endpoint(params).do_put
      end

      def destroy
        RubyLokaliseApi::Generics::DeletedResource.new(
          reinit_endpoint.do_delete[:content]
        )
      end

      def reload_data
        self.class.new reinit_endpoint.do_get
      end

      class << self
        def inherited(subclass)
          klass_attributes = attributes_for subclass.base_name

          subclass.class_exec do
            const_set :ATTRS, klass_attributes
            attr_reader(*klass_attributes)
          end

          super
        end

        def no_support_for(methods)
          return unless methods.any?
          
          methods.each do |method|
            undef_method(method)
          end
        end
      end

      private

      def reinit_endpoint(req_params = {})
        query_params = self.class.const_get(:MAIN_PARAMS).to_array.map do |param|
          instance_variable_get "@#{param}"
        end

        @endpoint.reinitialize(query_params: query_params, req_params: req_params)
      end

      def populate_attrs_from(content)
        return unless content

        data_key = data_key_for model_class: self.class.base_name

        supported_attrs.each do |attrib|
          value = if content.key?(data_key) && content[data_key].is_a?(Hash) && content[data_key].key?(attrib)
                    content[data_key][attrib]
                  else
                    content[attrib]
                  end

          instance_variable_set "@#{attrib}", value
        end
      end

      def supported_attrs
        self.class.const_get(:ATTRS)
      end
    end
  end
end
