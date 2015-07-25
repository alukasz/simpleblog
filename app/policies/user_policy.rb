class UserPolicy < ApplicationPolicy
  def index?
    @user.admin? if @user
  end

  def show?
    true
  end

  def update?
    @user.admin? if @user
  end
end
