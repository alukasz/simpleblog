describe PostPolicy do
  let(:user) { create :user }
  let(:admin) { create :admin }

  subject { PostPolicy }

  permissions :index? do
    it { is_expected.to permit user }
    it { is_expected.to permit admin }
  end

  permissions :show? do
    it { is_expected.to permit user }
    it { is_expected.to permit admin }
  end

  permissions :new? do
    it { is_expected.not_to permit user }
    it { is_expected.to permit admin }
  end

  permissions :create? do
    it { is_expected.not_to permit user }
    it { is_expected.to permit admin }
  end

  permissions :edit? do
    it { is_expected.not_to permit user }
    it { is_expected.to permit admin }
  end

  permissions :update? do
    it { is_expected.not_to permit user }
    it { is_expected.to permit admin }
  end

  permissions :destroy? do
    it { is_expected.not_to permit user }
    it { is_expected.to permit admin }
  end
end
