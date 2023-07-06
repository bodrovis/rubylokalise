# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Screenshot do
  let(:project_id) { '88628569645b945648b474.25982965' }

  let(:loaded_screen_fixture) { loaded_fixture('screenshots/screenshot') }

  let(:screen_id) { loaded_screen_fixture['screenshot']['screenshot_id'] }

  let(:screen_endpoint) do
    endpoint name: 'Screenshots', client: test_client, params: { query: [screen_id] }
  end

  let(:screen) do
    resource 'Screenshot', content: loaded_screen_fixture, endpoint: screen_endpoint
  end

  specify '#reload_data' do
    stub(
      uri: "projects/#{project_id}/screenshots/#{screen_id}",
      resp: { body: fixture('screenshots/screenshot') }
    )

    reloaded_screen = screen.reload_data

    expect(reloaded_screen.screenshot_id).to eq(screen_id)
  end
end
