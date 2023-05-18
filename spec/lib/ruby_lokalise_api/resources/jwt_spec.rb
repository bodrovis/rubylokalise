# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Jwt do
  subject do
    described_class.new content: nil, endpoint: nil
  end

  it { is_expected.not_to respond_to(:update) }
  it { is_expected.not_to respond_to(:destroy) }
  it { is_expected.not_to respond_to(:reload_data) }
end
