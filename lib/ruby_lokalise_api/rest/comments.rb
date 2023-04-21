# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Comments
      def comment(project_id, key_id, comment_id)
        main_endpoint_load names: { endpoint: 'KeyComments', resource: 'Comment' },
                           params: { query: [project_id, key_id, comment_id] }
      end
    end
  end
end
