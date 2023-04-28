# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Client do
  context 'with API errors' do
    it 'raises BadRequest when API token is invalid' do
      token = 'fake token'

      stub(
        uri: 'projects',
        req: { token: token },
        resp: {
          body: fixture('errors/invalid_token'),
          code: 400
        }
      )

      expect do
        test_client(token).projects
      end.to raise_error(RubyLokaliseApi::Error::BadRequest, /Invalid `X-Api-Token` header/)
    end
  end
end
