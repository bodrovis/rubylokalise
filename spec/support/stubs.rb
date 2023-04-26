# frozen_string_literal: true

module Stubs
  def stub(uri:, resp: {}, req: {}, params: {})
    stub_request(
      params.fetch(:verb, :get),
      "#{RubyLokaliseApi::Endpoints::Main::MainEndpoint::BASE_URL}/#{uri}"
    ).with(
      request_params(req, params)
    ).to_return(
      response_params(resp, params)
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

  def response_params(resp, setup_params)
    params = {
      status: setup_params.fetch(:code, 200)
    }

    params[:body] = resp[:body] if resp[:body]

    params[:headers] = resp[:headers] if resp[:headers]

    params
  end

  def request_params(req, setup_params)
    params = { headers: {
      'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip,deflate,br',
      'User-Agent' => "ruby-lokalise-api gem/#{RubyLokaliseApi::VERSION}",
      'X-Api-Token' => setup_params.fetch(:token) { test_client.token }
    } }

    # The default :object mode encode hashes in a way that's not properly
    # recognized by Webmock
    params[:body] = Oj.dump(req[:body], mode: :strict) if req[:body]

    params[:query] = req[:query] if req[:query]

    params
  end
end
