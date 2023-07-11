# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Branch do
  specify '#reload_data' do
    loaded_fixture = loaded_fixture('branches/branch')
    project_id = loaded_fixture['project_id']
    branch_id = loaded_fixture['branch']['branch_id']

    ep = endpoint name: 'Branches', client: test_client, params: { query: [project_id, branch_id] }
    branch = resource 'Branch', content: loaded_fixture, endpoint: ep

    stub(
      uri: "projects/#{project_id}/branches/#{branch_id}",
      resp: { body: fixture('branches/branch') }
    )

    reloaded_branch = branch.reload_data

    expect(reloaded_branch.branch_id).to eq(branch_id)
    expect(reloaded_branch.project_id).to eq(project_id)
  end
end
