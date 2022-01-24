class SubmissionSetsController < ApplicationController
	before_action :get_survey
	before_action :set_submission_set, only: %i[show update destroy]

	# GET /submission_sets
	def index
		# only survey owner can see all submission_sets
		require_requester_to_be(@survey.user) and return

		@submission_sets = @survey.submission_sets
		render json: @submission_sets
	end

	# GET /submission_sets/1
	def show
		if @submission_set.nil?
			render :nothing => true, status: if params[:id] == 'self' then 204 else 403 end
			return
		end
		return render :nothing => true, status: 404 unless @submission_set
		# survey owner and the person who submitted can see a submission_set
		if @submission_set.survey.user.email != @requester_email &&
				@submission_set.user.email != @requester_email
			return render :nothing => true, status: 403
		end
		render json: @submission_set
	end

	# POST /submission_sets
	def create
		return render nothing: true, status: 400 unless submission_params[:submissions]
		if submission_params[:submissions].length !=
				@survey.questions.length
			return render nothing: true, status: 400
		end
		ActiveRecord::Base.transaction do
			u = User.find_by(email: @requester_email)
			@submission_set = SubmissionSet.new(submission_set_params)
			@submission_set.survey = @survey
			@submission_set.user = u
			if !@submission_set.save
				render json: @submission_set.errors, status: :unprocessable_entity
				raise ActiveRecord::Rollback
			end
			submission_params[:submissions].each_with_index do |val, index|
				s = Submission.new(val)
				s.submission_set = @submission_set
				if !s.save!
					render json: s.errors, status: :unprocessable_entity
					raise ActiveRecord::Rollback
				end
			end
			render json: @submission_set, status: 200
		end
	end

	# PATCH/PUT /submission_sets/1
	def update
		# submission_set is immutable
		render :nothing => true, status: 405
	end

	# DELETE /submission_sets/1
	def destroy
		# only submitter owner can destroy a submisison_set
		require_requester_to_be(@submission_set.user) and return
		@submission_set.destroy
	end

	private

	def get_survey
		@survey = Survey.find(params[:survey_id])
	end

	# Use callbacks to share common setup or constraints between actions.
	def set_submission_set
		if params[:id] == 'self'
			puts "self route"
			u = User.where(email: @requester_email).first
			puts "user is #{u}"
			@submission_set = SubmissionSet.where(user_id: u.id).where(survey_id: @survey.id).first
			puts "submission_set is #{@submission_set}"
		else
		   @submission_set = SubmissionSet.find(params[:id])
		end
	end

	# Only allow a list of trusted parameters through.
	def submission_set_params
		params
			.require(:submission_set)
			.permit(:user_id, :survey_id)
	end
	def submission_params
		params.permit(submissions: [:type, :question_id, :answer, answer: []])
	end
end
