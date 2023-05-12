# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Files do
  let(:project_id) { '88628569645b945648b474.25982965' }

  specify '#files' do
    stub(
      uri: "projects/#{project_id}/files",
      resp: { body: fixture('files/files') }
    )

    files = test_client.files project_id

    expect(files.collection.length).to eq(4)
    expect_to_have_valid_resources(files)

    file = files[0]

    expect(file.file_id).to eq(1_642_774)
    expect(file.project_id).to eq(project_id)
    expect(file.branch).to eq('master')
    expect(file.filename).to eq('main-%LANG_ISO%.json')
    expect(file.key_count).to eq(2)
  end

  specify '#destroy_file' do
    file_to_delete = 1_652_771
    doc_project_id = '92226400645e7e02104994.93406932'

    stub(
      uri: "projects/#{doc_project_id}/files/#{file_to_delete}",
      req: { verb: :delete },
      resp: { body: fixture('files/destroy_file') }
    )

    resp = test_client.destroy_file(doc_project_id, file_to_delete)

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(doc_project_id)
    expect(resp.file_deleted).to be true
  end
end
