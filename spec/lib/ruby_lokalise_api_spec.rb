# frozen_string_literal: true

RSpec.describe RubyLokaliseApi do
  specify '.client' do
    expect(test_client).to be_an_instance_of(RubyLokaliseApi::Client)
    expect(test_client.token).to eq(ENV.fetch('LOKALISE_API_TOKEN', nil))
    expect(test_client.timeout).to be_nil
    expect(test_client.open_timeout).to be_nil
  end

  specify '.reset_client!' do
    expect(test_client).to be_an_instance_of(RubyLokaliseApi::Client)
    described_class.reset_client!
    current_client = described_class.instance_variable_get :@client
    expect(current_client).to be_nil
  end
end
