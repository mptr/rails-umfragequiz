class SubmissionsController < ApplicationController
	before_action :get_submisson_set
	before_action :set_submission, only: %i[show update destroy]

	# GET /submissions
	def index
		# only survey owner can see all submissions
		if @submission_set.survey.user.email != @requester_email &&
				@submission_set.user.email != @requester_email
			return render nothing: true, status: 403
		end
		@submissions = @submission_set.submissions
		render json: @submissions
	end

	# GET /submissions/1
	def show
		# survey owner and the person who created the submission can show it
		if @submission.submission_set.survey.user.email != @requester_email &&
				@submission.submission_set.user.email != @requester_email
			return render nothing: true, status: 403
		end
		render json: @submission
	end

	# POST /submissions
	def create
		render nothing: true, status: 405
	end

	# PATCH/PUT /submissions/1
	def update
		render nothing: true, status: 405
	end

	# DELETE /submissions/1
	def destroy
		render nothing: true, status: 405
	end

	private

	def get_submisson_set
		@submission_set = SubmissionSet.find(params[:submission_set_id])
	end

	# Use callbacks to share common setup or constraints between actions.
	def set_submission
		@submission = Submission.find(params[:id])
	end
end
