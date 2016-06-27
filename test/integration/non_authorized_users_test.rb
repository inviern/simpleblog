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
end
