# frozen_string_literal: true

module RubyLokaliseApi
  module Request
    include RubyLokaliseApi::JsonHandler
    include RubyLokaliseApi::Connection

    # Lokalise returns pagination info in special headers
    PAGINATION_HEADERS = %w[x-pagination-total-count x-pagination-page-count x-pagination-limit
                            x-pagination-page].freeze

    def get(endpoint)
      respond_with(
        connection(endpoint).get(prepare(endpoint.uri), endpoint.req_params),
        endpoint
      )
    end

    def post(endpoint)
      respond_with(
        connection(endpoint).post(prepare(endpoint.uri), custom_dump(endpoint.req_params)),
        endpoint
      )
    end

    def put(endpoint)
      respond_with(
        connection(endpoint).put(prepare(endpoint.uri), custom_dump(endpoint.req_params)),
        endpoint
      )
    end

    def patch(path, client, params = {})
      respond_with(
        connection(client).patch(prepare(path), params.any? ? custom_dump(params) : nil),
        client
      )
    end

    def delete(endpoint)
      respond_with(
        connection(endpoint).delete(prepare(endpoint.uri)) do |req|
          req.body = custom_dump endpoint.req_params
        end,
        endpoint
      )
    end

    private

    # Get rid of double slashes in the `path`, leading and trailing slash
    def prepare(path)
      path.delete_prefix('/').gsub(%r{//}, '/').gsub(%r{/+\z}, '')
    end

    def raise_on_error!(response, body)
      return unless !response.success? || (body.respond_to?(:has_key?) && body.key?('error'))

      respond_with_error(response.status, body)
    end

    def respond_with(response, endpoint)
      body = custom_load response.body

      raise_on_error! response, body

      extract_headers_from(response).
        merge(content: body,
              endpoint: endpoint)
    end

    # Keep only pagination headers
    def extract_headers_from(response)
      response.
        headers.
        to_h.
        keep_if { |header, _value| PAGINATION_HEADERS.include?(header) }.
        transform_keys(&:to_sym)
    end

    def respond_with_error(code, body)
      raise(RubyLokaliseApi::Error, body['error'] || body) unless RubyLokaliseApi::Error::ERRORS.key? code

      raise RubyLokaliseApi::Error::ERRORS[code].from_response(body)
    end
  end
end
