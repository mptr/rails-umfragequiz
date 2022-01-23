class SurveysController < ApplicationController
	before_action :get_user
	before_action :set_survey, only: %i[show update destroy]

	# creates a post object that's associated with the specific user instance from the get_user method
	def new
		@survey = @user.survey.build
	end

	# GET /surveys
	def index
		# if it is called via user, only show the users surveys
		if @user
			@surveys = @user.surveys
			# otherwise show all available surveys (user-independent)
		else
			@surveys = Survey.all
		end

		render json: @surveys
	end

	# GET /surveys/1
	def show
		render json: @survey
	end

	# POST /surveys
	def create
		return render nothing: true, status: 400 if @user == nil
		ActiveRecord::Base.transaction do
			@survey = Survey.new(survey_params)
			@survey.user = @user
			if @survey.save

			else
				return(
					render json: @survey.errors, status: :unprocessable_entity
				)
			end
			question_params[:questions].each_with_index do |val, index|
				q = Question.new(val)
				q.survey = @survey
				if q.save

				else
					return(
						render json: @survey.errors,
						       status: :unprocessable_entity
					)
				end
			end
			render json: @survey, status: 200
		end
	end

	# PATCH/PUT /surveys/1
	def update
		# only survey owner can update a survey
		require_requester_to_be(@survey.user)

		if @survey.update(survey_params)
			render json: @survey
			return
		else
			render json: @survey.errors, status: :unprocessable_entity
			return
		end
	end

	# DELETE /surveys/1
	def destroy
		# only survey owner can destroy a survey
		require_requester_to_be(@survey.user)

		@survey.destroy
	end

	private

	def get_user
		if params[:user_id] == nil
			@user = nil
		else
			@user = User.find(params[:user_id])
		end
	end

	# Use callbacks to share common setup or constraints between actions.
	def set_survey
		if @user
			@survey = @user.surveys.find(params[:id])
		else
			@survey = Survey.find(params[:id])
		end
	end

	def survey_params
		params.require(:survey).permit(:name, :from_date, :to_date, :user_id)
	end
	def question_params
		params.permit(
			questions: [
				:optional,
				:description,
				:position,
				:survey_id,
				:type,
				:random_order,
				:up_to,
				:from,
				:to,
				:step,
				answer_options: [],
				questions: []
			]
		)
	end
end
