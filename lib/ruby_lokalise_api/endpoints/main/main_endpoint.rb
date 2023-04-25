# frozen_string_literal: true

module RubyLokaliseApi
  module Endpoints
    module Main
      class MainEndpoint < RubyLokaliseApi::Endpoints::BaseEndpoint
        include RubyLokaliseApi::Request

        BASE_URL = 'https://api.lokalise.com/api2'
      end
    end
  end
end
