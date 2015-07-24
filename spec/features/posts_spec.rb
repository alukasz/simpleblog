feature 'Posts' do
  scenario 'listing posts' do
    first_post = create(:post)
    second_post = create(:post)

    visit root_path

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

  scenario 'friendly id generates slug' do
    first_post = create :post
    second_post = create :post
    third_post = create :post

    visit post_path(first_post)
    expect(current_path).to match(/post-title/)
    visit post_path(second_post)
    expect(current_path).to match(/post-title-2/)
    visit post_path(third_post)
    expect(current_path).to match(/post-title-3/)
  end
end
