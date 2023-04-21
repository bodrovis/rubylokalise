# frozen_string_literal: true

module RubyLokaliseApi
  module Contracts
    class NewProjectContract < BaseContract
      json do
        required(:name).value(:string)
      end
    end
  end
end
