# frozen_string_literal: true

require 'zeitwerk'
require 'faraday'
require 'faraday/gzip'
require 'yaml'
require 'addressable/template'
require 'dry/validation'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect(
  'oauth2' => 'OAuth2',
  'oauth2_client' => 'OAuth2Client'
)
loader.setup

# Official Ruby client for Lokalise APIv2
module RubyLokaliseApi
  class << self
    # Initializes a new Client object
    #
    # @return [RubyLokaliseApi::Client]
    # @param token [String]
    # @param params [Hash]
    def client(token, params = {})
      @client = RubyLokaliseApi::Client.new token, params
    end

    # Reset the currently set client
    def reset_client!
      @client = nil
    end
  end
end
