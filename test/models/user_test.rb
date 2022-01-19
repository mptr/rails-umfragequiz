require "test_helper"

class UserTest < ActiveSupport::TestCase
	test "Username validations" do
		u = User.new
		u.email = "testuser@mydomain.com"

		# tests username presence
		assert_not u.save, "Saved user without username"

		# tests if valid username is saveable
		u.username = "Testuser01"
		assert u.save, "Failed to save user with valid username"

		# tests username uniqueness
		u2 = User.new
		u2.email = "testuser02@mydomain.com"
		u2.username = u.username
		assert_not u2.save, "Username is not unique but duplicate"
	end

	test "Usermail validations" do
		u = User.new
		u.username = "Testuser01"

		# tests email presence
		assert_not u.save, "Saved user without email"

		# tests invalid email
		u.email = "someemail"
		assert_not u.save, "Saved user with invalid email"

		# tests if valid email is saveable
		u.email = "testuser@mydomain.com"
		assert u.save, "Failed to save user with valid email"

		# tests email uniqueness
		u2 = User.new
		u2.username = "Testuser02"
		u2.email = u.email
		assert_not u2.save, "Email is not unique but duplicate"
	end

	test "Survey association" do
		u = User.new
		u.username = "Testuser01"
		u.email = "testuser@mydomain.com"
		
		assert_equal 0, u.surveys.length, "new User already has associated Surveys"
		# u.surveys.append(Survey.first)
	end 

	test "SubmissionSet association" do
		u = User.new
		u.username = "Testuser01"
		u.email = "testuser@mydomain.com"

		assert_equal 0, u.submission_sets.length, "new User already has associated SubmissionSets"
	end
end
