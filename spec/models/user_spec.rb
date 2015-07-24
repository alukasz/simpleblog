require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(create(:user)).to be_valid
  end

  context 'validation' do
    it { is_expected.to validate_presence_of :name }
  end
end
