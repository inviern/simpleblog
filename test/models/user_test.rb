require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'test_user', email: 'test@example.com', password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  # name
  test "valid names should be accepted" do
    valid_names = %w[testuser Testuser testuser1 test_user test-user]
    valid_names.each do |valid_name|
      @user.name = valid_name
      assert @user.valid?, "#{valid_name} should be valid"
    end
  end

  test "name should not be empty" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 33
    assert_not @user.valid?
  end

  test "invalid names should be rejected" do
    invalid_names = %w[test.user test,user test@#%^& тест]
    invalid_names << "test user"
    invalid_names.each do |invalid_name|
      @user.name = invalid_name
      assert_not @user.valid?, "#{invalid_name} should be invalid"
    end
  end

  test "name should be unique" do
    @user.save
    another_user = @user.dup
    another_user.name = @user.name.upcase
    another_user.email = "different@example.com"
    assert_not another_user.valid?
  end

  # email
  test "valid emails should be accepted" do
    valid_emails = %w[user@example.com USER@examle.COM U_S-ER@exam.ple.com test.user@example.com test+user@example.com]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email} should be valid"
    end
  end

  test "email should not be empty" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 21 + "@example.com"
    assert_not @user.valid?
  end

  test "invalid emails should be rejected" do
    invalid_emails = %w[user@example,com user_at_example.com user@example. user@exam_ple.com user@exam+ple.com]
    invalid_emails << "us er@example.com"
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email} should be invalid"
    end
  end

  test "email should be unique" do
    @user.save
    another_user = @user.dup
    another_user.name = "different"
    another_user.email = @user.email.upcase
    assert_not another_user.valid?
  end

  # password
  test "password should not be too short" do
    @user.password = "a" * 5
    assert_not @user.valid?
  end

  test "password confirmation should match password" do
    @user.password_confirmation = "password_"
    assert_not @user.valid?
  end

end
