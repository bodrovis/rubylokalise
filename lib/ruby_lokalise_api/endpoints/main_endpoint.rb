# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    class MainEndpoint < BaseEndpoint
      include RubyLokaliseApi::Request

      BASE_URL = 'https://api.lokalise.com/api2'
    end
  end
end
