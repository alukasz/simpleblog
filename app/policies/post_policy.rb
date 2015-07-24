class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    index?
  end

  def new?
    @user.admin?
  end

  def create?
    new?
  end

  def edit?
    @user.admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
