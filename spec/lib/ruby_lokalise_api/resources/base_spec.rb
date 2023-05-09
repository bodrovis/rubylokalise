# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Base do
  let(:base_resource) do
    resource 'Base', content: nil, endpoint: base_endpoint
  end

  let(:base_endpoint) do
    endpoint 'Base', test_client, query: []
  end

  specify '#[]' do
    allow(base_resource).to receive(:self_endpoint).and_return(base_endpoint)

    expect(base_resource[:self_endpoint]).to eq(base_endpoint)
    expect(base_resource['self_endpoint']).to eq(base_endpoint)
    expect(base_resource['wrong_attr']).to be_nil
    expect(base_resource[:wrong_attr]).to be_nil
  end
end
