require 'test_helper'

class AuthorizedUsersTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:first)
    @another_user = users(:second)
    login_as @user
  end

  # General layout
  test "logged in users should see new post link" do
    get root_path
    assert_select "a[href=?]", new_post_path
  end

  test "logged in users should see their blog link after new post link" do
    get root_path
    assert_select "a[href=?]+a[href=?]", new_post_path, blog_path(@user.name)
  end

  test "logged in users should see profile link" do
    get root_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "logged in users should see logout link" do
    get root_path
    assert_select "a[href=?]", logout_path
  end

  test "logged in users should not see login link" do
    get root_path
    assert_select "a[href=?]", login_path, count: 0
  end

  test "logged in users should not see signup link" do
    get root_path
    assert_select "a[href=?]", signup_path, count: 0
  end

  # Users
  # Profile page (users#show)
  test "authorized users should see links to edit their own profile" do
    get user_path(@user)
    assert_select "a[href=?]", edit_user_path
  end

  test "authorized users should see links to delete their own profile" do
    get user_path(@user)
    assert_select "a[href=?][data-method='delete']", user_path
  end

  test "authorized users should not see links to edit other user profiles" do
    get user_path(@another_user)
    assert_select "a[href=?]", edit_user_path, count: 0
  end

  test "authorized users should not see links to delete other user profiles" do
    get user_path(@another_user)
    assert_select "a[href=?][data-method='delete']", user_path(@another_user), count: 0
  end

  test "authorized users should see link to all users list" do
    get user_path(@user)
    assert_select "a[href=?]", users_path
  end

  # Home
  # All posts page (home#index)
  test "authorized users should see links to edit their own posts on homepage" do
    get root_path
    post = @user.posts.first
    assert_select "a[href=?]", edit_post_path(post)
  end

  test "authorized users should see links to delete their own posts on homepage" do
    get root_path
    post = @user.posts.first
    assert_select "a[href=?][data-method='delete']", post_path(post)
  end

  test "authorized users should not see links to edit other user posts on homepage" do
    get root_path
    post = @another_user.posts.first
    assert_select "a[href=?]", edit_post_path(post), count: 0
  end

  test "authorized users should not see links to delete other user posts on homepage" do
    get root_path
    post = @another_user.posts.first
    assert_select "a[href=?][data-method='delete']", post_path(post), count: 0
  end

  # Posts
  # User's posts page (posts#index)
  test "authorized users should see links to edit their own posts" do
    get blog_path(@user.name)
    post = @user.posts.first
    assert_select "a[href=?]", edit_post_path(post)
  end

  test "authorized users should see links to delete their own posts" do
    get blog_path(@user.name)
    post = @user.posts.first
    assert_select "a[href=?][data-method='delete']", post_path(post)
  end

  test "authorized users should not see links to edit other user posts" do
    get blog_path(@another_user.name)
    post = @another_user.posts.first
    assert_select "a[href=?]", edit_post_path(post), count: 0
  end

  test "authorized users should not see links to delete other user posts" do
    get blog_path(@another_user.name)
    post = @another_user.posts.first
    assert_select "a[href=?][data-method='delete']", post_path(post), count: 0
  end

  # Post detail page (posts#show)
  test "authorized users should see edit links on their own post detail pages" do
    post = @user.posts.first
    get blog_post_path(@user.name, post)
    assert_select "a[href=?]", edit_post_path(post)
  end

  test "authorized users should see delete links on their own post detail pages" do
    post = @user.posts.first
    get blog_post_path(@user.name, post)
    assert_select "a[href=?][data-method='delete']", post_path(post)
  end

  test "authorized users should not see edit links on other users post detail pages" do
    post = @another_user.posts.first
    get blog_post_path(@another_user.name, post)
    assert_select "a[href=?]", edit_post_path(post), count: 0
  end

  test "authorized users should not see delete links on other users post detail pages" do
    post = @another_user.posts.first
    get blog_post_path(@another_user.name, post)
    assert_select "a[href=?][data-method='delete']", post_path(post), count: 0
  end
end
