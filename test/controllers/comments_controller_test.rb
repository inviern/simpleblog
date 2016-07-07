require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @comment = comments(:first)
    @user = users(:first)
    @another_user = users(:second)
    @post = posts(:first)
  end

  # create
  test 'authorized users should create comments' do
    login_user(@user, login_path)
    assert_difference 'Comment.count', 1 do
      post :create, post_id: @post, comment: { text: 'text' }
    end
  end

  test 'non-authorized users should not create comments' do
    post :create, post_id: @post
    assert_redirected_to login_path
  end

  # destroy
  test 'authorized users should destroy their comments' do
    login_user(@comment.author, login_path)
    assert_difference 'Comment.count', -1 do
      delete :destroy, id: @comment
    end
  end

  test 'authorized users should not destroy other user comments' do
    login_user(@another_user, login_path)
    assert_no_difference 'Comment.count' do
      delete :destroy, id: @comment
    end
  end

  test 'non-authorized users should not destroy comments' do
    delete :destroy, id: @comment
    assert_redirected_to login_path
  end
end
