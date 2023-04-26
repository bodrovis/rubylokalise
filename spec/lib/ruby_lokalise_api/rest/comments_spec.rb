# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Comments do
  let(:project_id) { '20603843642073fe124fb8.14291681' }
  let(:key_id) { 301_832_195 }
  let(:comment_id) { 16_588_650 }

  specify '#comment' do
    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/comments/#{comment_id}",
      resp: { body: fixture('comments/comment') }
    )

    comment = test_client.comment(project_id, key_id, comment_id)

    expect(comment.project_id).to eq(project_id)
    expect(comment.comment_id).to eq(comment_id)
    expect(comment.key_id).to eq(key_id)
    expect(comment.comment).to eq('<p>Hi!</p>')
    expect(comment.added_by).to eq(20_181)
    expect(comment.added_by_email).to eq('bodrovis@protonmail.com')
    expect(comment.added_at).to eq('2023-04-21 14:11:11 (Etc/UTC)')
    expect(comment.added_at_timestamp).to eq(1_682_086_271)
  end
end
