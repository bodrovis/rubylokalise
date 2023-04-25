# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Keys
      using RubyLokaliseApi::Utils::Strings

      def data_key_for(model_class:)
        get_key name: 'DATA_KEY', model_class: model_class
      end

      # Returns the name of the API resource for the given class.
      # Most class names correspond to resource names (eg, `Project`, `Team`)
      # but some may differ (`ProjectComment` corresponds to `Comment` resource).
      # The resource name is in lowercase, with underscores as separators.
      # Some resources also have different pluralization rules. For example,
      # "CustomTranslationStatus" is "CustomTranslationStatuses" (-es postfix).
      # To address that, we try to fetch `DATA_KEY_PLURAL` set for the individual class.
      #
      # @return [String]
      # @param model_class [String]
      # @param plural [Boolean] Should the returned value be pluralized?
      # def data_key_for(model_class:, plural: false, collection: false)
      #   data_key_plural = get_key(
      #     name: 'DATA_KEY_PLURAL',
      #     model_class: model_class,
      #     collection: true,
      #     strict: true
      #   )

      #   return data_key_plural if collection && data_key_plural

      #   data_key = get_key name: 'DATA_KEY', model_class: model_class, collection: collection

      #   return data_key unless plural

      #   "#{data_key}s"
      # end

      def get_key(name:, model_class:)
        key = if Module.const_defined? "RubyLokaliseApi::Resources::#{model_class}::#{name}"
                Module.const_get "RubyLokaliseApi::Resources::#{model_class}::#{name}"
              else
                model_class.delete_suffix('Resource')
              end

        # Sometimes key is nil
        key ? key.snakecase : key
      end

      # def get_key(name:, model_class:, collection: false, strict: false)
      #   key = if collection && Module.const_defined?("RubyLokaliseApi::Collections::#{model_class}::#{name}")
      #           Module.const_get "RubyLokaliseApi::Collections::#{model_class}::#{name}"
      #         elsif Module.const_defined? "RubyLokaliseApi::Resources::#{model_class}::#{name}"
      #           Module.const_get "RubyLokaliseApi::Resources::#{model_class}::#{name}"
      #         else
      #           strict ? nil : model_class.delete_suffix('Resource')
      #         end

      #   # Sometimes key is nil
      #   key ? key.snakecase : key
      # end
    end
  end
end
