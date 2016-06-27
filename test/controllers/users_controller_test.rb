require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @user = users(:first)
  end

  # index
  test "authorized users should see all users list page" do
    login_user(@user, login_path)
    get :index
    assert_template 'users/index'
  end

  test "non-authorized users should not see all users list page" do
    get :index
    assert_redirected_to root_path
  end

  # show
  test "all users should see user profile show page" do
    get :show, id: @user.id
    assert_template 'users/show'
  end

  # new
  test "logged in users should not see signup page" do
    login_user(@user, login_path)
    get :new
    assert_redirected_to root_path
  end

  test "logged out users should see signup page" do
    get :new
    assert_template 'users/new'
  end

  # edit
  test "authorized users should see their own profile edit page" do
    login_user(@user, login_path)
    get :edit, id: @user.id
    assert_template 'users/edit'
  end

  test "non-authorized users should not see profile edit pages" do
    get :edit, id: @user.id
    assert_redirected_to root_path
  end

  # create
  test "logged in users should not be able to create account" do
    login_user(@user, login_path)
    post :create
    assert_redirected_to root_path
  end

  # update
  test "non-authorized users should not be able to update user profiles" do
    patch :update, id: @user.id
    assert_redirected_to root_path
  end

  # destroy
  test "non-authorized users should not be able to delete user profiles" do
    delete :destroy, id: @user.id
    assert_redirected_to root_path
  end
end