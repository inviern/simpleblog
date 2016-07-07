require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = comments(:first)
  end

  test 'should be valid' do
    assert @comment.valid?
  end

  # text
  test 'text should not be empty' do
    @comment.text = ' '
    assert_not @comment.valid?
  end

  test 'text should not be too long' do
    @comment.text = 'a' * 10_001
    assert_not @comment.valid?
  end

  # post
  test 'comment should have a post' do
    @comment.post = nil
    assert_not @comment.valid?
  end

  # author
  test 'comment should have an author' do
    @comment.author = nil
    assert_not @comment.valid?
  end
end
