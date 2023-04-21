# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    include Utils::Loaders

    include Rest::Comments
    include Rest::Contributors
    include Rest::Projects
  end
end
