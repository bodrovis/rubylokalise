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

      class << self
        def inherited(subclass)
          klass_attributes = attributes_for subclass.base_name

          subclass.class_exec do
            const_set :ATTRS, klass_attributes
            attr_reader(*klass_attributes)
          end

          super
        end
      end

      private

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