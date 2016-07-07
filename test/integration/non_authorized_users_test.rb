require 'test_helper'

class NonAuthorizedUsersTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:first)
  end

  # General layout
  test 'logged out users should see login link' do
    get root_path
    assert_select 'a[href=?]', login_path
  end

  test 'logged out users should see signup link' do
    get root_path
    assert_select 'a[href=?]', signup_path
  end

  test 'logged out users should not see new post link' do
    get root_path
    assert_select 'a[href=?]', new_post_path, count: 0
  end

  test 'logged out users should not see logout link' do
    get root_path
    assert_select 'a[href=?]', logout_path, count: 0
  end

  # Users
  # Profile page (users#show)
  test 'non-authorized users should not see links to edit user profiles' do
    get user_path(@user)
    assert_select 'a[href=?]', edit_user_path(@user), count: 0
  end

  test 'non-authorized users should not see links to delete user profiles' do
    get user_path(@user)
    assert_select 'a[href=?][data-method="delete"]', user_path(@user), count: 0
  end

  test 'non-authorized users should not see link to all users list' do
    get user_path(@user)
    assert_select 'a[href=?]', users_path, count: 0
  end

  # Home
  # All posts page (home#index)
  test 'non-authorized users should not see links to edit posts on home' do
    get root_path
    post = @user.posts.first
    assert_select 'a[href=?]', edit_post_path(post), count: 0
  end

  test 'non-authorized users should not see links to delete posts on home' do
    get root_path
    post = @user.posts.first
    assert_select 'a[href=?][data-method="delete"]', post_path(post), count: 0
  end

  # Posts
  # User's posts page (posts#index)
  test 'non-authorized users should not see links to edit posts' \
       ' on blog pages' do
    get root_path
    post = @user.posts.first
    assert_select 'a[href=?]', edit_post_path(post), count: 0
  end

  test 'non-authorized users should not see links to delete posts' \
       ' on blog pages' do
    get root_path
    post = @user.posts.first
    assert_select 'a[href=?][data-method="delete"]', post_path(post), count: 0
  end

  # Post detail page (posts#show)
  test 'non-authorized users should not see links to edit on post' \
       ' detail pages' do
    post = @user.posts.first
    get blog_post_path(@user.name, post)
    assert_select 'a[href=?]', edit_post_path(post), count: 0
  end

  test 'non-authorized users should not see links to delete on post' \
       ' detail pages' do
    post = @user.posts.first
    get blog_post_path(@user.name, post)
    assert_select 'a[href=?][data-method="delete"]', post_path(post), count: 0
  end

  # Comments
  test 'non-authorized users should not see add comment form on detail post page' do
    post = posts(:first)
    get blog_post_path(post.author.name, post)
    assert_select 'form[action=?][method="post"]', post_comments_path(post),
                  count: 0
  end
end
