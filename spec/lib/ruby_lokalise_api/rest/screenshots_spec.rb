# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Screenshots do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:screenshot_id) { 2_858_588 }

  specify '#screenshots' do
    stub(
      uri: "projects/#{project_id}/screenshots",
      resp: { body: fixture('screenshots/screenshots') }
    )

    screenshots = test_client.screenshots project_id

    expect(screenshots.collection.length).to eq(3)
    expect_to_have_valid_resources(screenshots)
    expect(screenshots.project_id).to eq(project_id)
    expect(screenshots.branch).to eq('master')

    screenshot = screenshots[0]

    expect(screenshot.screenshot_id).to eq(2_858_588)
  end

  specify '#screenshot' do
    stub(
      uri: "projects/#{project_id}/screenshots/#{screenshot_id}",
      resp: { body: fixture('screenshots/screenshot') }
    )

    screenshot = test_client.screenshot project_id, screenshot_id

    expect(screenshot.project_id).to eq(project_id)
    expect(screenshot.branch).to eq('master')
    expect(screenshot.screenshot_id).to eq(screenshot_id)
    expect(screenshot.key_ids).to include(319_782_369)
    expect(screenshot.keys[0]['key_id']).to eq(319_782_369)
    expect(screenshot.url).to include('lokalise-live-lok-app-main-assets')
    expect(screenshot.title).to eq('Registration')
    expect(screenshot.description).to eq('')
    expect(screenshot.screenshot_tags).to eq([])
    expect(screenshot.width).to eq(572)
    expect(screenshot.height).to eq(438)
    expect(screenshot.created_at).to eq('2023-04-18 16:52:10 (Etc/UTC)')
    expect(screenshot.created_at_timestamp).to eq(1_681_836_730)
  end
end
