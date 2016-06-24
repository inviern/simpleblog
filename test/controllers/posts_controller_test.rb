require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  def setup
    @author = users(:first)
    @post = posts(:first)
  end

  test "should get index" do
    get :index, author: @author.name
    assert_response :success
  end

  test "should get show" do
    get :show, author: @post.author.name, id: @post
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

end
