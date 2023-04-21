# frozen_string_literal: true

module TestClient
  def test_client(token = nil, params = {})
    RubyLokaliseApi::Client.new(token || ENV.fetch('LOKALISE_API_TOKEN', nil), params)
  end
end
