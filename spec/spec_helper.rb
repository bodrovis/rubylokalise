# frozen_string_literal: true

require 'dotenv/load'
require 'simplecov'
require 'webmock/rspec'
require 'factory_bot'
require 'oj'

SimpleCov.start do
  add_filter 'spec/'
  add_filter '.github/'
end

require 'ruby_lokalise_api'

# Support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.include TestClient
  config.include Stubs
  config.include RubyLokaliseApi::Utils::Loaders

  config.before(:suite) do
    Fixtures.eager_load

    # WebMock.allow_net_connect!
  end
end
