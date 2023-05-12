# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    include Utils::Loaders

    include Rest::Comments
    include Rest::Contributors
    include Rest::CustomTranslationStatuses
    include Rest::Files
    include Rest::Projects
    include Rest::QueuedProcesses
  end
end
