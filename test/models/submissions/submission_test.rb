require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  def setup
    @q = Submission.new(submission_set: SubmissionSet.first, question: Question.first)
  end
  include AbstractClassTest
end
