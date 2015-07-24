require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has a valid factory' do
    expect(create(:post)).to be_valid
  end

  context 'validation' do
    it { is_expected.to validate_presence_of(:title) }

    it { is_expected.to validate_presence_of(:teaser) }

    it { is_expected.to validate_presence_of(:text) }
  end
end
