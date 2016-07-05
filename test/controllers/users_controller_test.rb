require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @user = users(:first)
  end

  # index
  test 'authorized users should see all users page' do
    login_user(@user, login_path)
    get :index
    assert_template 'users/index'
  end

  test 'non-authorized users should not see all users page' do
    get :index
    assert_redirected_to login_path
  end

  # show
  test 'all users should see user profile pages' do
    get :show, id: @user
    assert_template 'users/show'
  end

  # new
  test 'logged in users should not see signup page' do
    login_user(@user, login_path)
    get :new
    assert_redirected_to root_path
  end

  test 'logged out users should see signup page' do
    get :new
    assert_template 'users/new'
  end

  # edit
  test 'authorized users should see their own profile edit page' do
    login_user(@user, login_path)
    get :edit, id: @user
    assert_template 'users/edit'
  end

  test 'non-authorized users should not see profile edit pages' do
    get :edit, id: @user
    assert_redirected_to login_path
  end

  # create
  test 'logged in users should not create account' do
    login_user(@user, login_path)
    post :create
    assert_redirected_to root_path
  end

  test 'user should log in after signup' do
    post :create, user: {
      name: 'newuser',
      email: 'newuser@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
    assert logged_in?
  end

  # update
  test 'non-authorized users should not update user profiles' do
    patch :update, id: @user
    assert_redirected_to login_path
  end

  # destroy
  test 'non-authorized users should not delete user profiles' do
    delete :destroy, id: @user
    assert_redirected_to login_path
  end
end
