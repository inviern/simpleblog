require 'test_helper'

class AuthorizedUsersTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:first)
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
end
