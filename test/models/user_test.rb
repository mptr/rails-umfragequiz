require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @u = User.new(username: "TestUser", email: "testuser01@mydomain.com")
  end

  test "should validate username" do
    @u.username = nil
    assert_not @u.save, "Saved without username"

    @u.username = ""
    assert_not @u.save, "Saved with empty username"

    @u.username = "Testuser01"
    assert @u.save, "Failed to save with valid username"

    u2 = @u.dup
    u2.email = "testuser02@mydomain.com"
    assert_not u2.save, "Saved with duplicate username"
  end

  test "should validate email" do
    @u.email = nil
    assert_not @u.save, "Saved without email"

    @u.email = ""
    assert_not @u.save, "Saved with empty email"

    @u.email = "testuser01@mydomain.com"
    assert @u.save, "Failed to save with valid email"

    u2 = @u.dup
    u2.username = "Testuser02"
    assert_not u2.save, "Saved with duplicate email"
  end

  test "should not have associations" do
    @u.save
    assert_equal 0, @u.surveys.length, "already has associated surveys"
    assert_equal 0, @u.submission_sets.length, "already has associated submissions"
  end 
end
