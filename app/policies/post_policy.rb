class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    index?
  end

  def new?
    @user.admin? if @user
  end

  def create?
    new?
  end

  def edit?
    (@user.admin? if @user) && @user.id == @record.user_id
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
