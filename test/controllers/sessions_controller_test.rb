require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @user = users(:first)
  end

  # new
  test "logged in users should not see login page" do
    login_user(@user, login_path)
    get :new
    assert_redirected_to root_path
  end

  test "logged out users should see login page" do
    get :new
    assert_template 'sessions/new'
  end

  # create
  test "should login successfully" do
    post :create, session: { email: @user.email, password: "password"}
    assert_response :redirect
  end

  # destroy
  test "should logout successfully" do
    delete :destroy
    assert_redirected_to root_path
  end

end
