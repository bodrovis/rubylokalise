# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Contributors do
  let(:project_id) { '20603843642073fe124fb8.14291681' }
  let(:user_id) { 20181 }

  specify '#contributor' do
    stub(
      uri: "projects/#{project_id}/contributors/#{user_id}",
      resp: fixture('contributors/contributor')
    )

    contributor = test_client.contributor project_id, user_id

    expect(contributor).to be_an_instance_of(RubyLokaliseApi::Resources::ContributorResource)
  end
end