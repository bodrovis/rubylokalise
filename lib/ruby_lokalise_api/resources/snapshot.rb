# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Snapshot < Base
      MAIN_PARAMS = %i[project_id snapshot_id].freeze
      no_support_for %i[update reload_data]

      # Restores the given snapshot by creating a project copy
      #
      # @see https://developers.lokalise.com/reference/restore-a-snapshot
      # @return [RubyLokaliseApi::Resources::Project]
      def restore
        params = { query: [@project_id, @snapshot_id] }

        restored_project = endpoint(name: 'Snapshots', client: @self_endpoint.client, params: params).do_post

        # We restore a project so its endpoint is different
        restored_project[:endpoint] = endpoint(name: 'Projects', params: { query: [@project_id] })

        resource 'Project', restored_project
      end
    end
  end
end
