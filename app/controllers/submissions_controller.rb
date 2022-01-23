class SubmissionsController < ApplicationController
  before_action :get_submisson_set
  before_action :set_submission, only: [:show, :update, :destroy]

  # GET /submissions
  def index
    # only survey owner can see all submissions
    require_requester_to_be(@submission_set.survey.user)

    @submissions = @submission_set.submissions
    render json: @submissions
  end

  # GET /submissions/1
  def show
    # survey owner and the person who created the submission can show it
    if @submission.submission_set.survey.user.email != requester_email || @submission.submission_set.user != requester_email then
      render :nothing => true, :status => 403
    end
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
    # only the person who created the submission can update it (not survey owner)
    require_requester_to_be(@submission.submission_set.user)

    if @submission.update(submission_params)
      render json: @submission
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  # DELETE /submissions/1
  def destroy
    # only the person who created the submission can destroy it (not survey owner)
    require_requester_to_be(@submission.submission_set.user)
    
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
