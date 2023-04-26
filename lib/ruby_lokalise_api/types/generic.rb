# frozen_string_literal: true

module RubyLokaliseApi
  module Types
    class Generic
      include RubyLokaliseApi::Concerns::HashAccessible

      def initialize(raw_data)
        raw_data.each do |att, val|
          instance_variable_set "@#{att}", val

          self.class.class_exec do
            attr_reader att.to_sym
          end
        end
      end
    end
  end
end
