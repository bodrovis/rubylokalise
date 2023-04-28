# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Comments
      def comment(project_id, key_id, comment_id)
        endpoint_resource names: { endpoint: 'KeyComments', resource: 'Comment' },
                          params: { query: [project_id, key_id, comment_id] }
      end

      def comments(project_id, key_id, req_params = {})
        endpoint_collection names: { endpoint: 'KeyComments', collection: 'KeyComments' },
                            params: { query: [project_id, key_id], req: req_params }
      end
    end
  end
end
