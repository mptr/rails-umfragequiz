class SubmissionsController < ApplicationController
  before_action :get_submisson_set
  before_action :set_submission, only: [:show, :update, :destroy]

  # GET /submissions
  def index
    # @submissions = Submission.all
    @submissions = @submission_set.submissions

    render json: @submissions
  end

  # GET /submissions/1
  def show
    render json: @submission
  end

  # POST /submissions
  def create
    @submission = Submission.new(submission_params)
    @submission_set.submissions.append(@submission)

    if @submission.save
      render json: @submission, status: :created
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /submissions/1
  def update
    if @submission.update(submission_params)
      render json: @submission
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  # DELETE /submissions/1
  def destroy
    @submission.destroy
  end

  private
    def get_submisson_set
      @submission_set = SubmissionSet.find(params[:submission_set_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:submission_set_id, :question_id, :type, :answer)
    end
end
