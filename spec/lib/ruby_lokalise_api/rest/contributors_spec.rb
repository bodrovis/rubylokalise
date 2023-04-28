# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Contributors do
  let(:project_id) { '20603843642073fe124fb8.14291681' }
  let(:user_id) { 20_181 }

  specify '#contributor' do
    stub(
      uri: "projects/#{project_id}/contributors/#{user_id}",
      resp: { body: fixture('contributors/contributor') }
    )

    contributor = test_client.contributor project_id, user_id

    expect(contributor.user_id).to eq(user_id)
    expect(contributor.email).to eq('bodrovis@protonmail.com')
    expect(contributor.fullname).to eq('Ilya B')
    expect(contributor.created_at).to eq('2018-08-21 15:35:25 (Etc/UTC)')
    expect(contributor.created_at_timestamp).to eq(1_534_865_725)
    expect(contributor.is_admin).to be true
    expect(contributor.is_reviewer).to be true
    expect(contributor.languages).to include(
      'lang_id' => 10_001,
      'lang_iso' => 'custom_1',
      'lang_name' => 'Quenya',
      'is_writable' => true
    )
    expect(contributor.admin_rights).to include('upload')
  end

  specify '#contributors' do
    stub(
      uri: "projects/#{project_id}/contributors",
      resp: { body: fixture('contributors/contributors') }
    )

    contributors = test_client.contributors project_id
    expect(contributors.collection.length).to eq(3)

    contributor = contributors[0]

    expect(contributor).to be_an_instance_of(RubyLokaliseApi::Resources::Contributor)
    expect(contributor.user_id).to eq(20_181)
    expect(contributor.project_id).to eq(project_id)
  end
end
