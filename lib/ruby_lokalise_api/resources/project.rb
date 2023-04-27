# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Project < Base
      MAIN_PARAMS = 'project_id'

      def key_comment(key_id, comment_id)
        main_endpoint_res(
          names: { endpoint: 'KeyComments', resource: 'Comment' },
          params: { query: [@project_id, key_id, comment_id] },
          client: @endpoint.client
        )
      end
    end
  end
end
