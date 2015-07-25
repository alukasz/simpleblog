describe PostPolicy do
  let(:user) { create :user }
  let(:admin) { create :admin }
  let(:other_admin) { create :admin }

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

    it 'allows admin to edit their own post' do
      expect(subject).to permit(admin, admin)
    end

    it 'prevents edit if admin is not auhtor of post' do
      expect(subject).not_to permit(admin, other_admin)
    end
  end

  permissions :update? do
    it { is_expected.not_to permit user }

    it 'allows admin to update their own post' do
      expect(subject).to permit(admin, admin)
    end

    it 'prevents updates if admin is not auhtor of post' do
      expect(subject).not_to permit(admin, other_admin)
    end
  end

  permissions :destroy? do
    it { is_expected.not_to permit user }

    it 'allows admin to destroy their own post' do
      expect(subject).to permit(admin, admin)
    end

    it 'prevents destroy if admin is not auhtor of post' do
      expect(subject).not_to permit(admin, other_admin)
    end
  end
end
