# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Types::Generic do
  subject { described_class.new(endpoint: 'stub', answer: 42) }

  it_behaves_like 'hash accessible'

  it { is_expected.to respond_to(:answer) }
  it { is_expected.not_to respond_to(:wrong_reader) }
end
