require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :user }

  describe 'guest access' do
    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'assigns the requested user to @user' do
        get :show, id: user
        expect(assigns(:user)).to eq user
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: user, user: { admin: true }
        expect(response).to require_login
      end
    end
  end

  describe 'user access' do
    before :each do
      sign_in create :user
    end

    describe 'GET #index' do
      it 'requires permissions' do
        get :index
        expect(response).to require_permissions
      end
    end

    describe 'GET #show' do
      it 'assigns the requested user to @user' do
        get :show, id: user
        expect(assigns(:user)).to eq user
      end
    end

    describe 'PATCH #update' do
      it 'requires permissions' do
        patch :update, id: user, user: { admin: true }
        expect(response).to require_permissions
      end
    end
  end

  describe 'admin access' do
    before :each do
      @admin = create :admin
      sign_in @admin
    end

    describe 'GET #index' do
      it 'populates an array of users to @users' do
        some_user = create :user
        some_admin = create :admin

        get :index
        expect(assigns(:users)).to match_array [@admin, some_user, some_admin]
      end
    end

    describe 'GET #show' do
      it 'assigns the requested user to @user' do
        get :show, id: user
        expect(assigns(:user)).to eq user
      end
    end

    describe 'PATCH #update'do
      it 'updates user admin attribute' do
        user = create :user
        patch :update, id: user, user: { admin: true }
        user.reload
        expect(user).to be_admin
      end
    end
  end
end
