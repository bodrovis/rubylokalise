# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::CustomTranslationStatuses do
  let(:project_id) { '20603843642073fe124fb8.14291681' }
  let(:status_id) { 14_421 }

  specify '#custom_translation_status' do
    stub(
      uri: "projects/#{project_id}/custom_translation_statuses/#{status_id}",
      resp: { body: fixture('cts/status') }
    )

    status = test_client.custom_translation_status project_id, status_id

    expect(status.status_id).to eq(status_id)
    expect(status.title).to eq('approved')
    expect(status.color).to eq('#0079bf')
  end

  specify '#custom_translation_statuses' do
    stub(
      uri: "projects/#{project_id}/custom_translation_statuses",
      resp: {
        body: fixture('cts/statuses'),
        headers: {
          'x-pagination-total-count': '3',
          'x-pagination-page-count': '1',
          'x-pagination-limit': '100',
          'x-pagination-page': '1'
        }
      }
    )

    statuses = test_client.custom_translation_statuses project_id

    expect(statuses).to be_an_instance_of(RubyLokaliseApi::Collections::CustomTranslationStatuses)
    expect(statuses.total_results).to eq(3)
    expect_to_have_valid_resources(statuses)
  end
end
