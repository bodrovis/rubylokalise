# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Contributors
      def contributor(project_id, contributor_id)
        main_endpoint_res names: { endpoint: 'Contributors', resource: 'Contributor' },
                          params: { query: [project_id, contributor_id] }
      end

      def contributors(project_id, req_params = {})
        main_endpoint_collection names: { endpoint: 'Contributors', collection: 'Contributors' },
                                 params: { query: project_id, req: req_params }
      end
    end
  end
end
