# frozen_string_literal: true

module Stubs
  def stub(uri:, resp: {}, req: nil, params: {})
    stub_request(
      params.fetch(:verb, :get),
      "#{RubyLokaliseApi::Endpoints::Main::MainEndpoint::BASE_URL}/#{uri}"
    ).with(
      response_params(req, params)
    ).to_return(
      status: params.fetch(:code, 200),
      body: resp
    )
  end

  def loaded_fixture(filename)
    Oj.load fixture(filename)
  end

  def fixture(filename)
    File.new("#{fixture_path}/#{filename}.json")
  end

  private

  def fixture_path
    File.expand_path('../fixtures', __dir__)
  end

  def response_params(req, setup_params)
    params = {
      headers: {
        'Accept' => 'application/json',
        'Accept-Encoding' => 'gzip,deflate,br',
        'User-Agent' => "ruby-lokalise-api gem/#{RubyLokaliseApi::VERSION}",
        'X-Api-Token' => setup_params.fetch(:token) { test_client.token }
      }
    }

    # The default :object mode encode hashes in a way that's not properly
    # recognized by Webmock
    params[:body] = Oj.dump(req, mode: :strict) if req

    params
  end
end
