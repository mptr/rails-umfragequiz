class SubmissionSetsController < ApplicationController
  before_action :get_survey
  before_action :set_submission_set, only: [:show, :update, :destroy]

  # GET /submission_sets
  def index
    # @submission_sets = SubmissionSet.all
    @submission_sets = @survey.submission_sets

    render json: @submission_sets
  end

  # GET /submission_sets/1
  def show
    render json: @submission_set
  end

  # POST /submission_sets
  def create
    @submission_set = SubmissionSet.new(submission_set_params)
    @survey.submission_sets.append(@submission_set)

    if @submission_set.save
      render json: @submission_set, status: :created
    else
      render json: @submission_set.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /submission_sets/1
  def update
    if @submission_set.update(submission_set_params)
      render json: @submission_set
    else
      render json: @submission_set.errors, status: :unprocessable_entity
    end
  end

  # DELETE /submission_sets/1
  def destroy
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
      params.require(:submission_set).permit(:submittedAt, :user_id, :survey_id)
    end
end
