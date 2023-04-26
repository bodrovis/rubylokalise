# frozen_string_literal: true

module RubyLokaliseApi
  module Utils
    module Classes
      refine Object do
        # Turn `Module::Nested::ClassName` to just `ClassName`
        def base_name
          name.split('::').last
        end
      end
    end
  end
end
