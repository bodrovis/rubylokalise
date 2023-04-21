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
end
