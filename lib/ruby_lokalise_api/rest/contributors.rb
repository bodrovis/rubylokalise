# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Contributors
      def contributor(project_id, contributor_id)
        main_endpoint_res names: { endpoint: 'Contributors', resource: 'Contributor' },
                          params: { query: [project_id, contributor_id] }
      end
    end
  end
end
