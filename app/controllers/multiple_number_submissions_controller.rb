class MultipleNumberSubmissionsController < ApplicationController
  before_action :set_multiple_number_submission, only: [:show, :update, :destroy]

  # GET /multiple_number_submissions
  def index
    @multiple_number_submissions = MultipleNumberSubmission.all

    render json: @multiple_number_submissions
  end

  # GET /multiple_number_submissions/1
  def show
    render json: @multiple_number_submission
  end

  # POST /multiple_number_submissions
  def create
    @multiple_number_submission = MultipleNumberSubmission.new(multiple_number_submission_params)

    if @multiple_number_submission.save
      render json: @multiple_number_submission, status: :created, location: @multiple_number_submission
    else
      render json: @multiple_number_submission.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /multiple_number_submissions/1
  def update
    if @multiple_number_submission.update(multiple_number_submission_params)
      render json: @multiple_number_submission
    else
      render json: @multiple_number_submission.errors, status: :unprocessable_entity
    end
  end

  # DELETE /multiple_number_submissions/1
  def destroy
    @multiple_number_submission.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multiple_number_submission
      @multiple_number_submission = MultipleNumberSubmission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def multiple_number_submission_params
      params.require(:multiple_number_submission).permit(:rearrangeable_question_id)
    end
end
