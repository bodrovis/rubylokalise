# frozen_string_literal: true

module RubyLokaliseApi
  module OAuth2
    class Auth
      attr_reader :client_id, :client_secret, :timeout, :open_timeout

      OAUTH2_ENDPOINT = RubyLokaliseApi::Endpoints::OAuth2::OAuth2Endpoint

      def initialize(client_id, client_secret, params = {})
        @client_id = client_id
        @client_secret = client_secret
        @timeout = params[:timeout]
        @open_timeout = params[:open_timeout]
      end

      def oauth2_endpoint
        self.class.const_get(:OAUTH2_ENDPOINT)
      end

      def auth(scope:, redirect_uri: nil, state: nil)
        endpoint = oauth2_endpoint.new self

        scope = scope.join(' ') if scope.is_a?(Array)

        params = {
          client_id: client_id,
          scope: scope
        }
        params[:state] = state unless state.nil?
        params[:redirect_uri] = redirect_uri unless redirect_uri.nil?

        _build_url_from endpoint, params
      end

      def token(code)
        endpoint = oauth2_endpoint.new(
          self,
          query: :token,
          req: common_params.merge(
            grant_type: 'authorization_code',
            code: code
          )
        )

        RubyLokaliseApi::Resources::OAuth2Token.new endpoint.do_post
      end

      def refresh(refresh_token)
        endpoint = oauth2_endpoint.new(
          self,
          query: :token,
          req: common_params.merge(
            grant_type: 'refresh_token',
            refresh_token: refresh_token
          )
        )

        RubyLokaliseApi::Resources::OAuth2RefreshedToken.new endpoint.do_post
      end

      private

      def common_params
        {
          client_id: @client_id,
          client_secret: @client_secret
        }
      end

      def _build_url_from(endpoint, params)
        uri = URI(endpoint.base_url)

        URI::HTTPS.build(
          host: uri.host,
          path: "#{uri.path}/auth",
          query: URI.encode_www_form(params)
        ).to_s
      end
    end
  end
end
