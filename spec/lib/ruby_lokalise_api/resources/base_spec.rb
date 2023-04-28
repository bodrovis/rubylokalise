# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Base do
  subject do
    resource 'Base', content: nil, endpoint: base_endpoint
  end

  let(:base_endpoint) do
    endpoint 'Base', test_client, query: []
  end

  it_behaves_like 'hash accessible'
end
