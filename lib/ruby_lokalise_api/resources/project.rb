# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Project < Base
      def update(params)
        update_endpoint = @endpoint.reinitialize(req_params: params)

        self.class.new update_endpoint.do_put
      end

      def destroy
        main_endpoint_delete endpoint: 'Projects',
                             params: { query: [@project_id] },
                             client: @endpoint.client
      end

      def reload_data
        reloaded_endpoint = @endpoint.reinitialize(query_params: [@project_id], req_params: {})

        self.class.new reloaded_endpoint.do_get
      end

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
