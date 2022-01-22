ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def generate_token_for(u)
    "Bearer magically-generated #{u.email} #{u.username}"
  end
end

# a test case that checks if saving an instance of an abstract class is prevented
# requires @q to be defined as the question to be tested
module AbstractClassTest
  def test_should_be_abstract_class
    assert_not @q.save, 'Saved instance of abstract class'
  end
end
