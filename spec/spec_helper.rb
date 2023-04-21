# frozen_string_literal: true

require 'dotenv/load'
require 'webmock/rspec'
require 'factory_bot'
require 'oj'

require 'ruby_lokalise_api'

# Support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.include TestClient
  config.include Stubs
end
