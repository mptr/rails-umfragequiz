require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "User validations" do
    u = User.new
    assert_not u.save, "Saved user without email & username"
    u.email = "someemail"
    assert_not u.save, "Saved user without username"
    u.username = "Testuser01"
    assert_not u.save, "Saved user with invalid email"
    u.email = "testuser@mydomain.com"
    assert u.save, "Failed to save user"
  end
end
