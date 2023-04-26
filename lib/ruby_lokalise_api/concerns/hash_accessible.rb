# frozen_string_literal: true

module RubyLokaliseApi
  module Concerns
    module HashAccessible
      def [](raw_key_attr)
        key_attr = :"@#{raw_key_attr}"

        return nil unless instance_variables.include?(key_attr)

        instance_variable_get(key_attr)
      end
    end
  end
end
