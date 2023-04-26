# frozen_string_literal: true

RSpec.shared_examples 'hash accessible' do
  specify '#[]' do
    expect(subject[:endpoint]).not_to be_nil
    expect(subject['endpoint']).not_to be_nil
    expect(subject['wrong_attr']).to be_nil
    expect(subject[:wrong_attr]).to be_nil
  end
end
