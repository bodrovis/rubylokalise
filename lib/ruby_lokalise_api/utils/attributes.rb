# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Attributes
      using RubyLokaliseApi::Utils::Strings

      private

      UNIFIED_RESOURCES = %w[comment language].freeze

      # Loads attributes for the given resource based on its name
      #
      # @return [Array<String>]
      def attributes_for(klass)
        name = unify klass.base_name.snakecase

        @attributes ||= YAML.load_file(File.expand_path('../data/attributes.yml', __dir__)).freeze

        @attributes[name]
      end

      # Unify some resources' names (eg, `ProjectComment` and `KeyComment` have the same
      # attributes which are stored under `comment`).
      # Also get rid of the "_resource" postfix
      #
      # @return [String]
      def unify(name)
        UNIFIED_RESOURCES.each do |u_a|
          return u_a if name.match?(/#{u_a}/)
        end

        name.delete_suffix '_resource'
      end
    end
  end
end
