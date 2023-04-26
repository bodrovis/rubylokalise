# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Project do
  let(:loaded_project_fixture) { loaded_fixture('projects/project') }

  let(:project_id) { loaded_project_fixture['project_id'] }

  let(:project_endpoint) do
    endpoint 'Main::Projects', { query: [project_id] }, test_client
  end

  let(:project) do
    resource 'Project', content: loaded_project_fixture, endpoint: project_endpoint
  end

  specify '#update' do
    params = { name: 'OnBoarding-2023', description: 'Updated description' }

    stub(
      uri: "projects/#{project_id}",
      req: { body: params },
      resp: { body: fixture('projects/update_project') },
      params: { verb: :put }
    )

    updated_project = project.update params

    expect(updated_project).to be_an_instance_of(described_class)
  end

  specify '#destroy' do
    created_project_fixture = loaded_fixture('projects/create_project')
    created_project_id = created_project_fixture['project_id']
    created_project = resource 'Project',
                               content: created_project_fixture,
                               endpoint: endpoint('Main::Projects', { query: [created_project_id] }, test_client)

    stub(
      uri: "projects/#{created_project_id}",
      resp: { body: fixture('projects/destroy_project') },
      params: { verb: :delete }
    )

    resp = created_project.destroy
    expect(resp.project_id).to eq(created_project_id)
    expect(resp['project_id']).to eq(created_project_id)
    expect(resp.project_deleted).to be true
  end

  specify '#key_comment' do
    key_id = 301_832_195
    comment_id = 16_588_650

    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/comments/#{comment_id}",
      resp: { body: fixture('comments/comment') }
    )

    comment = project.key_comment(key_id, comment_id)

    expect(comment).to be_an_instance_of(RubyLokaliseApi::Resources::Comment)
  end

  it 'allows to reload data and perform subsequent requests' do
    params = { name: 'OnBoarding-2023', description: 'Updated description' }

    stub(
      uri: "projects/#{project_id}",
      resp: { body: fixture('projects/project') }
    )

    stub(
      uri: "projects/#{project_id}",
      req: { body: params },
      resp: { body: fixture('projects/update_project') },
      params: { verb: :put }
    )

    reloaded_project = project.reload_data

    updated_project = reloaded_project.update params

    expect(updated_project).to be_an_instance_of(described_class)

    key_id = 301_832_195
    comment_id = 16_588_650

    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/comments/#{comment_id}",
      resp: { body: fixture('comments/comment') }
    )

    reloaded_project = updated_project.reload_data

    expect(updated_project).to be_an_instance_of(described_class)

    comment = reloaded_project.key_comment(key_id, comment_id)

    expect(comment).to be_an_instance_of(RubyLokaliseApi::Resources::Comment)
  end
end