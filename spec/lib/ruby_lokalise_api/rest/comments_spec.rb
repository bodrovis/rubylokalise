# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Comments do
  let(:project_id) { '20603843642073fe124fb8.14291681' }
  let(:key_id) { 301_832_195 }
  let(:comment_id) { 16_588_650 }

  specify '#comment' do
    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/comments/#{comment_id}",
      resp: fixture('comments/comment')
    )

    comment = test_client.comment(project_id, key_id, comment_id)
    
    expect(comment).to be_an_instance_of(RubyLokaliseApi::Resources::CommentResource)
  end
end