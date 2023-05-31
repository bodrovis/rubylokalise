# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Key do
  let(:loaded_key_fixture) { loaded_fixture('keys/key2') }

  let(:project_id) { loaded_key_fixture['project_id'] }

  let(:key_endpoint) do
    params = { query: [project_id, loaded_key_fixture['key']['key_id']] }
    endpoint name: 'Keys', client: test_client, params: params
  end

  let(:key) do
    resource 'Key', content: loaded_key_fixture, endpoint: key_endpoint
  end

  let(:key_id) { key.key_id }

  specify '#reload_data' do
    stub(
      uri: "projects/#{project_id}/keys/#{key_id}",
      resp: { body: fixture('keys/key2') }
    )

    reloaded_key = key.reload_data

    expect(reloaded_key.key_id).to eq(key_id)
    expect(reloaded_key.project_id).to eq(project_id)
  end

  specify '#update' do
    desc = 'to delete'

    body = { description: desc }

    stub(
      uri: "projects/#{project_id}/keys/#{key_id}",
      req: { body: body, verb: :put },
      resp: { body: fixture('keys/update_key2') }
    )

    updated_key = key.update body

    expect(updated_key).to be_an_instance_of(described_class)
    expect(updated_key.key_id).to eq(key_id)
    expect(updated_key.description).to eq(desc)
  end

  specify '#destroy' do
    stub(
      uri: "projects/#{project_id}/keys/#{key_id}",
      req: { verb: :delete },
      resp: { body: fixture('keys/destroy_key') }
    )

    resp = key.destroy

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.key_removed).to be true
    expect(resp.keys_locked).to eq(0)
  end
end
