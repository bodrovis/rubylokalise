# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Projects do
  let(:project_id) { '20603843642073fe124fb8.14291681' }

  specify '#project' do
    stub(
      uri: "projects/#{project_id}",
      resp: fixture('projects/project')
    )

    project = test_client.project project_id

    expect(project).to be_an_instance_of(RubyLokaliseApi::Resources::ProjectResource)
  end

  specify '#create_project' do
    new_name = 'RubyNew'
    new_project_id = '526928826442cf2f60f643.34369791'

    stub(
      uri: 'projects',
      req: { 'name' => new_name },
      resp: fixture('projects/create_project'),
      params: { verb: :post }
    )

    stub(
      uri: "projects/#{new_project_id}",
      resp: fixture('projects/create_project')
    )

    new_project = test_client.create_project({ name: new_name })

    expect(new_project).to be_an_instance_of(RubyLokaliseApi::Resources::ProjectResource)

    reloaded_project = new_project.reload_data

    expect(reloaded_project).to be_an_instance_of(RubyLokaliseApi::Resources::ProjectResource)
  end
end
