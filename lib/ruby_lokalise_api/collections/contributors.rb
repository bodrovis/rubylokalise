# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Contributors < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::Main::ContributorsEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Contributor
    end
  end
end
