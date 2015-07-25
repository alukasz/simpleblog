require 'rails_helper'

describe UserPolicy do
  let(:user) { create :user }
  let(:admin) { create :admin }

  subject { UserPolicy }

  permissions :index? do
    it { is_expected.not_to permit user }
    it { is_expected.to permit admin }
  end

  permissions :show? do
    it { is_expected.to permit user }
    it { is_expected.to permit admin }
  end

  permissions :update? do
    it { is_expected.not_to permit user }
    it { is_expected.to permit admin }
  end
end
