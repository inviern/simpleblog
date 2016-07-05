require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @author = users(:first)
    @post = @author.posts.first
  end

  # index
  test 'all users should see blog pages' do
    get :index, author: @author.name
    assert_template 'posts/index'
  end

  # show
  test 'all users should see detail post pages' do
    get :show, author: @author.name, id: @post
    assert_template 'posts/show'
  end

  # new
  test 'authorized users should see new post page' do
    login_user(@author, login_path)
    get :new
    assert_template 'posts/new'
  end

  test 'non-authorized users should not see new post page' do
    get :new
    assert_redirected_to login_path
  end

  # edit
  test 'authorized users should see their own posts edit pages' do
    login_user(@author, login_path)
    get :edit, id: @post
    assert_template 'posts/edit'
  end

  test 'authorized users should not see other user posts edit pages' do
    login_user(@author, login_path)
    another_author = users(:second)
    post = another_author.posts.first
    get :edit, id: post
    assert_redirected_to root_path
  end

  test 'non-authorized users should not see edit post pages' do
    get :edit, id: @post
    assert_redirected_to login_path
  end

  # create
  test 'non-authorized users should not create posts' do
    post :create
    assert_redirected_to login_path
  end

  # update
  test 'non-authorized users should not update posts' do
    patch :update, id: @post
    assert_redirected_to login_path
  end

  # destroy
  test 'non-authorized users should not delete posts' do
    delete :destroy, id: @post
    assert_redirected_to login_path
  end
end
