require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @post = Post.new(title: "Example post", text: "Example text", user_id: 1)
  end

  test "should be valid" do
    assert @post.valid?
  end

  # title
  test "title should not be empty" do
    @post.title = " "
    assert_not @post.valid?
  end

  test "title should not be too long" do
    @post.title = "a" * 256
    assert_not @post.valid?
  end

  # text
  test "text should not be too long" do
    @post.text = "a" * 10001
    assert_not @post.valid?
  end

  # author
  test "post should have an author" do
    @post.author = nil
    assert_not @post.valid?
  end
end
