# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Projects do
  let(:project_id) { '20603843642073fe124fb8.14291681' }

  it 'works' do
    # WebMock.allow_net_connect!

    # stub(
    #   uri: "projects/#{project_id}",
    #   resp: fixture('project')
    # )

    # stub(
    #   uri: 'projects/20603843642073fe124fb8.14291681',
    #   req: {'name' => 'OnBoarding-2023', 'description' => 'desc'},
    #   resp: sample_project,
    #   params: {verb: :put}
    # )

    # stub(
    #   uri: 'projects/20603843642073fe124fb8.14291681',
    #   req: {'name' => 'OnBoarding-2023', 'description' => 'desc new'},
    #   resp: sample_project,
    #   params: {verb: :put}
    # )

    # project = test_client.project(project_id)
    # puts project.inspect
    # key_id = 306_573_175
    # comment_id = 16_549_635

    # stub(
    #   uri: "projects/20603843642073fe124fb8.14291681/keys/#{key_id}/comments/#{comment_id}",
    #   resp: sample_comment
    # )


    # res = project.update({name: 'OnBoarding-2023', description: 'desc'})

    # # # puts res.inspect
    # # puts res.class.name

    # res = project.update({name: 'OnBoarding-2023', description: 'desc new'})

    # reloaded = project.reload_data

    # puts reloaded.inspect

    # puts reloaded.key_comment(key_id, comment_id).inspect

    # puts res.inspect
  end

  specify '#create_project' do
    new_name = 'RubyNew'
    new_project_id = '526928826442cf2f60f643.34369791'

    stub(
      uri: "projects",
      req: {'name' => new_name},
      resp: fixture('create_project'),
      params: {verb: :post}
    )

    stub(
      uri: "projects/#{new_project_id}",
      resp: fixture('create_project')
    )

    new_project = test_client.create_project({name: new_name})
    puts new_project.to_h

   # reloaded = new_project.reload_data

   # puts reloaded.inspect
  end
end
