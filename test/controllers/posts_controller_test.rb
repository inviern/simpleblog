require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, user_name: "example"
    assert_response :success
  end

  test "should get show" do
    get :show, user_name: "example", id: 1
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: 1
    assert_response :success
  end

end
