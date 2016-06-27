require 'test_helper'

class NonAuthorizedUsersTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:first)
  end

  # Login
  test "should login successfully" do
    login_as @user
    assert_redirected_to blog_path(@user.name)
  end

  # General, sessions and layout
  test "logged out users should see login link" do
    get root_path
    assert_select "a[href=?]", login_path
  end

  test "logged out users should see signup link" do
    get root_path
    assert_select "a[href=?]", signup_path
  end

  test "logged out users should not see new post link" do
    get root_path
    assert_select "a[href=?]", new_post_path, count: 0
  end

  test "logged out users should not see logout link" do
    get root_path
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "logged out users should see login page" do
    get login_path
    assert_template 'sessions/new'
  end

  # Users
  # All users list (users#index)
  test "non-authorized users should not see all users list" do
    get users_path
    assert_redirected_to root_path
  end

  # Profile page (users#show)
  test "non-authorized users should not see links to edit user profiles" do
    get user_path(@user)
    assert_select "a[href=?]", edit_profile_path(@user), count: 0
  end

  test "non-authorized users should not see links to delete user profiles" do
    get user_path(@user)
    assert_select "a[href=?][data-method='delete']", user_path(@user), count: 0
  end

  test "non-authorized users should not see link to all users list" do
    get user_path(@user)
    assert_select "a[href=?]", users_path, count: 0
  end

  # Signup page (users#new)
  test "non-authorized users should see signup page" do
    get signup_path
    assert_template 'users/new'
  end

  # Edit profile page (users#edit)
  test "non-authorized users should not see edit profile pages" do
    get edit_profile_path(@user)
    assert_redirected_to root_path
  end

  # users#update
  test "non-authorized users should not be able to update user profiles" do
    patch user_path(@user), user: { id: @user.id }
    assert_redirected_to root_path
  end

  # users#destroy
  test "non-authorized users should not be able to delete user profiles" do
    delete user_path(@user)
    assert_redirected_to root_path
  end
end