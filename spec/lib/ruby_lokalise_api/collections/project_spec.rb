# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::Project do
  let(:loaded_projects_fixture) { loaded_fixture('projects/projects') }

  let(:project_endpoint) do
    endpoint 'Main::Projects', {}, test_client
  end

  let(:projects) do
    collection 'Project', content: loaded_projects_fixture, endpoint: project_endpoint
  end

  it 'allows to perform chaining on projects' do
    project = projects.collection.first
    project_id = project.project_id

    params = { name: 'Android i18n', description: 'chain updated' }

    stub(
      uri: "projects/#{project_id}",
      req: { body: params },
      resp: { body: fixture('projects/update_project2') },
      params: { verb: :put }
    )

    updated_project = project.update params

    expect(updated_project).to be_an_instance_of(RubyLokaliseApi::Resources::Project)
    expect(updated_project.description).to eq('chain updated')
  end
end
