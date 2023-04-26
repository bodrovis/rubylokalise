# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Project < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::Main::ProjectsEndpoint
      MAIN_PARAM = :project_id
    end
  end
end
