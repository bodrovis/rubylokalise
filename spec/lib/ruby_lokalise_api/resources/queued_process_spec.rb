# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::QueuedProcess do
  let(:process_fixture) { loaded_fixture('processes/process') }

  let(:project_id) { process_fixture['project_id'] }

  let(:process_endpoint) do
    endpoint(
      'QueuedProcesses',
      test_client,
      query: [
        project_id,
        process_fixture['process']['process_id']
      ]
    )
  end

  let(:process) do
    resource 'QueuedProcess', content: process_fixture, endpoint: process_endpoint
  end

  it 'does not support update' do
    expect(process).not_to respond_to(:update)
  end

  it 'does not support destroy' do
    expect(process).not_to respond_to(:destroy)
  end

  specify '#reload_data' do
    stub(
      uri: "projects/#{project_id}/processes/#{process.process_id}",
      resp: { body: fixture('processes/process') }
    )

    reloaded_process = process.reload_data

    expect(reloaded_process.process_id).to eq(process.process_id)
    expect(reloaded_process.project_id).to eq(project_id)
  end
end
