require 'test_helper'

class AuthorizedUsersTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:first)
    @another_user = users(:second)
    login_as @user
  end

  # Logout
  test "should logout successfully" do
    delete logout_path
    assert_redirected_to root_path
  end

  # General, sessions and layout
  test "logged in users should see new post link" do
    get root_path
    assert_select "a[href=?]", new_post_path
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

  test "logged in users should not see login page" do
    get login_path
    assert_redirected_to root_path
  end

  # Users
  # All users list (users#index)
  test "authorized users should see all users list" do
    get users_path
    assert_template 'users/index'
  end

  # Profile page (users#show)
  test "authorized users should see links to edit their own profile" do
    get user_path(@user)
    assert_select "a[href=?]", edit_profile_path
  end

  test "authorized users should see links to delete their own profile" do
    get user_path(@user)
    assert_select "a[href=?][data-method='delete']", user_path
  end

  test "authorized users should not see links to edit other user profiles" do
    get user_path(@another_user)
    assert_select "a[href=?]", edit_profile_path, count: 0
  end

  test "authorized users should not see links to delete other user profiles" do
    get user_path(@another_user)
    assert_select "a[href=?][data-method='delete']", user_path(@another_user), count: 0
  end

  test "authorized users should see link to all users list" do
    get user_path(@user)
    assert_select "a[href=?]", users_path
  end

  # Signup page (users#new)
  test "logged in users should not see signup page" do
    get signup_path
    assert_redirected_to root_path
  end

  # Edit profile page (users#edit)
  test "authorized users should see their own profile edit page" do
    get edit_profile_path(@user)
    assert_template 'users/edit'
  end

  # users#create
  test "logged in users should not be able to create account" do
    post users_path, user: {name: 'name', email: 'email@example.com', password: "password", password_confirmation: "password"}
    assert_redirected_to root_path
  end

  # Home
  # All posts page (homes#index)
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

  test "authorized users should see links delete links on their own post detail pages" do
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

  # New post page (posts#new)
  test "authorized users should see new post page" do
    get new_post_path
    assert_template 'posts/new'
  end

  # Edit post page (posts#edit)
  test "authorized users should see their own posts edit pages" do
    post = @user.posts.first
    get edit_post_path(post)
    assert_template 'posts/edit'
  end

  test "authorized users should not see other user posts edit pages" do
    post = @another_user.posts.first
    get edit_post_path(post)
    assert_redirected_to root_path
  end
end