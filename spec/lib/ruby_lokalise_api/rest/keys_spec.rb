# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Keys do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:key_id) { 319_782_376 }

  describe '#key' do
    it 'requests a key' do
      stub(
        uri: "projects/#{project_id}/keys/#{key_id}",
        resp: { body: fixture('keys/key') }
      )

      key = test_client.key project_id, key_id

      expect(key).to be_an_instance_of(RubyLokaliseApi::Resources::Key)
      expect(key.branch).to eq('master')
      expect(key.project_id).to eq(project_id)
      expect(key.key_id).to eq(key_id)
      expect(key.created_at).to eq('2023-04-24 11:24:38 (Etc/UTC)')
      expect(key.created_at_timestamp).to eq(1_682_335_478)
      expect(key.key_name['ios']).to eq('login')
      expect(key.filenames['web']).to eq('main-%LANG_ISO%.json')
      expect(key.description).to eq('')
      expect(key.platforms).to include('ios')
      expect(key.tags).to eq([])
      expect(key.comments).to eq([])
      expect(key.screenshots).to eq([])
      expect(key.translations[0]['language_iso']).to eq('en')
      expect(key.is_plural).to be false
      expect(key.plural_name).to eq('')
      expect(key.is_hidden).to be false
      expect(key.is_archived).to be false
      expect(key.context).to eq('')
      expect(key.base_words).to eq(2)
      expect(key.char_limit).to eq(0)
      expect(key.custom_attributes).to eq('')
      expect(key.modified_at).to eq('2023-05-10 13:10:57 (Etc/UTC)')
      expect(key.modified_at_timestamp).to eq(1_683_724_257)
      expect(key.translations_modified_at).to eq('2023-05-18 12:55:16 (Etc/UTC)')
      expect(key.translations_modified_at_timestamp).to eq(1_684_414_516)
    end

    it 'requests a key with a GET query param' do
      stub(
        uri: "projects/#{project_id}/keys/#{key_id}?disable_references=1",
        resp: { body: fixture('keys/key') }
      )

      key = test_client.key project_id, key_id, disable_references: 1

      expect(key).to be_an_instance_of(RubyLokaliseApi::Resources::Key)
      expect(key.project_id).to eq(project_id)
      expect(key.key_id).to eq(key_id)
    end
  end

  specify '#keys' do
    stub(
      uri: "projects/#{project_id}/keys",
      resp: { body: fixture('keys/keys') }
    )

    keys = test_client.keys project_id
    expect(keys.collection.length).to eq(5)
    expect_to_have_valid_resources(keys)
    expect(keys.project_id).to eq(project_id)
    expect(keys.branch).to eq('master')

    key = keys[0]

    expect(key.key_id).to eq(319_782_369)
    expect(key.project_id).to eq(project_id)
  end
end
