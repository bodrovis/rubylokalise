# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    include Utils::Loaders

    include Rest::Comments
    include Rest::Contributors
    include Rest::CustomTranslationStatuses
    include Rest::Files
    include Rest::Jwts
    include Rest::Keys
    include Rest::Languages
    include Rest::Orders
    include Rest::PaymentCards
    include Rest::Projects
    include Rest::QueuedProcesses
    include Rest::Teams
  end
end
