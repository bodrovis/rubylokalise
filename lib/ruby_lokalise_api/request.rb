# frozen_string_literal: true

module RubyLokaliseApi
  module Request
    include RubyLokaliseApi::BaseRequest

    # Lokalise returns pagination info in special headers
    PAGINATION_HEADERS = %w[x-pagination-total-count x-pagination-page-count x-pagination-limit
                            x-pagination-page].freeze

    private

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
        keep_if { |k, _v| PAGINATION_HEADERS.include?(k) }.
        transform_keys(&:to_sym)
    end
  end
end
