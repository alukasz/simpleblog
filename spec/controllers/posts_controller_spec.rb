RSpec.describe PostsController, type: :controller do
  let(:post) { create(:post) }
  let(:invalid_post) { create(:post) }
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  shared_examples_for 'everybody have to pass this' do
    describe 'GET #index' do
      it 'assigns an array of posts to @posts' do
        first_post = create(:post)
        second_post = create(:post)
        get :index
        expect(assigns(:posts)).to match_array [first_post, second_post]
      end
    end

    describe 'GET #show' do
      it 'assigns the requested post to @post' do
        get :show, id: post
        expect(assigns(:post)).to eq post
      end
    end
  end

  shared_examples_for 'public access to posts' do
    describe 'GET #new' do
      it 'requires login' do
        get :new
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, id: post
        expect(response).to require_login
      end
    end

    # describe 'POST #create' do
    #   it 'requires login' do
    #     post :create, id: post, post: attributes_for(:post)
    #     expect(response).to require_login
    #   end
    # end

    describe 'PUT #update' do
      it 'requires login' do
        put :update, id: post, post: attributes_for(:post)
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: post
        expect(response).to require_login
      end
    end
  end

  shared_examples_for 'user access to posts' do
    describe 'GET #new' do
      it 'requires permissions' do
        get :new
        expect(response).to require_permissions
      end
    end

    describe 'GET #edit' do
      it 'requires permissions' do
        get :edit, id: post
        expect(response).to require_permissions
      end
    end

    # describe 'POST #create' do
    #   it 'requires permissions' do
    #     post :create, id: post, post: attributes_for(:post)
    #     expect(response).to require_permissions
    #   end
    # end

    describe 'PUT #update' do
      it 'requires permissions' do
        put :update, id: post, post: attributes_for(:post)
        expect(response).to require_permissions
      end
    end

    describe 'DELETE #destroy' do
      it 'requires permissions' do
        delete :destroy, id: post
        expect(response).to require_permissions
      end
    end
  end

  shared_examples_for 'admin access to posts' do
    describe 'GET #new' do
      it 'assigns a new post to @post' do
        get :new
        expect(assigns(:post)).to be_a_new Post
      end
    end

    # describe 'POST #create' do
    #   context 'with valid attributions' do
    #     it 'saves the post in the database' do
    #       expect do
    #         post(:create, post: attributes_for(:post))
    #       end.to change(Post, :count).by 1
    #     end

    #     it 'redirects to post#show' do
    #       post(:create, post: attributes_for(:post))
    #       expect(response).to redirect_to post
    #     end
    #   end

    #   context 'with invalid attributes' do
    #     it 'does not save the post in the database' do
    #       expect do
    #         post :create, post: attributes_for(:post, title: '')
    #       end.not_to change(Post, :count)
    #     end

    #     it 're-renders post:new' do
    #       post :create, post: attributes_for(:post, title: '')
    #       expect(response).to render_template :new
    #     end
    #   end
    # end

    describe 'GET #edit' do
      it 'assigns the requested post to @post' do
        get :edit, id: post
        expect(assigns(:post)).to eq post
      end
    end

    describe 'PATCH #update' do
      context 'with valid attributions' do
        before :each do
          patch :update, id: post, post: attributes_for(
            :post, title: 'An updated Post'
          )
        end

        it 'assigns the post to @post' do
          expect(assigns(:post)).to eq post
        end

        it 'updates the post in the database' do
          post.reload
          expect(post.title).to eq 'An updated Post'
        end

        it 'redirects to post#show' do
          expect(response).to redirect_to post
        end
      end

      context 'with invalid attributes' do
        before :each do
          patch :update, id: post, post: attributes_for(:post, title: '')
        end

        it 'does not update the post in the database' do
          post.reload
          expect(post.title).to eq 'Post title'
        end

        it 're-renders posts#edit' do
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'assigns the requested post to @post' do
        delete :destroy, id: post
        expect(assigns(:post)).to eq post
      end

      it 'deletes the post' do
        post
        expect { delete :destroy, id: post }.to change(Post, :count).by(-1)
      end

      it 'redirects to posts#index' do
        delete :destroy, id: post
        expect(response).to redirect_to posts_path
      end
    end
  end

  describe 'guest access' do
    it_behaves_like 'everybody have to pass this'
    it_behaves_like 'public access to posts'
  end

  describe 'user access' do
    before :each do
      sign_in user
    end

    it_behaves_like 'everybody have to pass this'
    it_behaves_like 'user access to posts'
  end

  describe 'admin access' do
    before :each do
      sign_in admin
    end

    it_behaves_like 'everybody have to pass this'
    it_behaves_like 'admin access to posts'
  end
end
