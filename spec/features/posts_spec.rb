feature 'Posts' do
  context 'guest access' do
    scenario 'listing posts' do
      visit root_path

      expect(page).to have_css 'a.button', text: 'Log in'
      expect(page).to have_css 'a.button', text: 'Sign up'
      expect(page).to have_no_css 'a.button', text: 'New Post'
      expect(page).to have_no_css 'a.button', text: 'Account'
    end

    scenario 'viewing posts' do
      post = create :post

      visit post_path post

      expect(page).to have_css 'a.button', text: 'Back'
      expect(page).to have_no_css 'a.button', text: 'Edit Post'
      expect(page).to have_no_css 'a.button', text: 'Delete Post'
    end

    scenario 'creating posts' do
      visit new_post_path

      expect(page).to have_css '.flash-alert',
        text: 'You need to sign in or sign up before continuing.'
    end

    scenario 'editing posts' do
      post = create :post

      visit edit_post_path post

      expect(page).to have_css '.flash-alert',
        text: 'You need to sign in or sign up before continuing.'
    end
  end

  context 'user access' do
    background do
      user = create :user
      visit new_user_session_path
      fill_form(:user, email: user.email, password: user.password)
      click_button 'Log in'
    end

    scenario 'listing posts' do
      visit root_path

      expect(page).to have_css 'a.button', text: 'Account'
      expect(page).to have_css 'a.button', text: 'Logout'
      expect(page).to have_no_css 'a.button', text: 'New Post'
      expect(page).to have_no_css 'a.button', text: 'Log in'
    end

    scenario 'viewing posts' do
      post = create :post

      visit post_path post

      expect(page).to have_css 'a.button', text: 'Back'
      expect(page).to have_no_css 'a.button', text: 'Edit Post'
      expect(page).to have_no_css 'a.button', text: 'Delete Post'
    end

    scenario 'creating posts' do
      visit new_post_path

      expect(page).to have_css '.flash-alert',
        text: 'You are not authorized to perform this action.'
    end

    scenario 'editing posts' do
      post = create :post

      visit edit_post_path post

      expect(page).to have_css '.flash-alert',
        text:'You are not authorized to perform this action.'
    end
  end

  context 'admin access' do
    background do
      admin = create :admin

      visit new_user_session_path
      fill_form(:user, email: admin.email, password: admin.password)
      click_button 'Log in'
    end

    scenario 'listing posts' do
      first_post = create(:post)
      second_post = create(:post)

      visit root_path

      expect(page).to have_css 'a.button', text: 'Logout'
      expect(page).to have_title 'Latest Posts'
      expect(page).to have_css 'h2', text: first_post.title
      expect(page).to have_content second_post.teaser
    end

    scenario 'viewing posts' do
      post = create(:post)

      visit root_path
      click_link post.title

      expect(page).to have_title post.title
      expect(page).to have_css 'h2', text: post.title
      expect(page).to have_content post.text
      expect(page).to have_no_content post.teaser
    end

    scenario 'creating posts' do
      post = attributes_for :post

      visit root_path
      click_link 'New Post'
      fill_form(:post, post)
      click_button 'Create Post'

      expect(page).to have_css '.flash-success', text: 'Post has been created.'
      expect(page).to have_css 'h2', text: post[:title]
      expect(page).to have_content post[:text]
    end

    scenario 'editing posts' do
      post = create :post

      visit post_path(post)
      click_link 'Edit Post'
      expect(page).to have_title 'Edit Post'
      fill_form(:post,
        title: 'Edited Post',
        teaser: 'Click and read',
        text: 'New text'
      )
      click_button 'Update Post'

      expect(page).to have_css '.flash-success', text: 'Post has been updated.'
      expect(page).to have_title 'Edited Post'
      expect(page).to have_content 'New text'
    end

    scenario 'deleting post' do
      post = create :post

      visit post_path(post)
      click_link 'Delete Post'

      expect(page).to have_title 'Latest Post'
      expect(page).to have_no_content post.title
    end

    scenario 'visiting non existing post' do
      post = create :post

      post.destroy
      visit post_path(post)

      expect(page).to have_css '.flash-alert', text: 'Post not found.'
    end

    scenario 'friendly id generates correct post slug' do
      first_post = create :post
      second_post = create :post
      third_post = create :post

      visit post_path(first_post)
      expect(current_path).to match first_post.title.parameterize
      visit post_path(second_post)
      expect(current_path).to match "#{first_post.title.parameterize}-2"
      visit post_path(third_post)
      expect(current_path).to match "#{first_post.title.parameterize}-3"
    end
  end


end
