class SubmissionSetsController < ApplicationController
	before_action :get_survey
	before_action :set_submission_set, only: %i[show update destroy]

	# GET /submission_sets
	def index
		# only survey owner can see all submission_sets
		require_requester_to_be(@survey.user)

		@submission_sets = @survey.submission_sets
		render json: @submission_sets
	end

	# GET /submission_sets/1
	def show
		# survey owner and the person who submitted can see a submission_set
		if @submission_set.survey.user.email != requester_email ||
				@submission_set.user != requester_email
			return render nothing: true, status: 403
		end
		render json: @submission_set
	end

	# POST /submission_sets
	def create
		ActiveRecord::Base.transaction do
			if submission_params[:submissions].length !=
					@survey.questions.length
				return render nothing: true, status: 400
			end
			@submission_set = SubmissionSet.new(submission_set_params)
			@submission_set.survey = @survey
			if !@submission_set.save
				return(
					render json: @submission_set.errors,
					       status: :unprocessable_entity
				)
			end
			submission_params[:submissions].each_with_index do |val, index|
				s = Submission.new(val)
				s.submission_set = @submission_set
				if !s.save
					return render json: s.errors, status: :unprocessable_entity
				end
			end
			render json: @submission_set, status: 200
		end
	end

	# PATCH/PUT /submission_sets/1
	def update
		# submission_set can only be updated by the person who created it
		require_requester_to_be(@submission_set.user)

		if @submission_set.update(submission_set_params)
			render json: @submission_set
		else
			render json: @submission_set.errors, status: :unprocessable_entity
		end
	end

	# DELETE /submission_sets/1
	def destroy
		# only survey owner can destroy a submisison_set
		require_requester_to_be(@submission_set.survey.user)

		@submission_set.destroy
	end

	private

	def get_survey
		@survey = Survey.find(params[:survey_id])
	end

	# Use callbacks to share common setup or constraints between actions.
	def set_submission_set
		@submission_set = SubmissionSet.find(params[:id])
	end

	# Only allow a list of trusted parameters through.
	def submission_set_params
		params
			.require(:submission_set)
			.permit(:submittedAt, :user_id, :survey_id)
	end
	def submission_params
		params.permit(submissions: [:type, :answer, answer: []])
	end
end
