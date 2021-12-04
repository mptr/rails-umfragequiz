class TextSubmissionsController < ApplicationController
  before_action :set_text_submission, only: [:show, :update, :destroy]

  # GET /text_submissions
  def index
    @text_submissions = TextSubmission.all

    render json: @text_submissions
  end

  # GET /text_submissions/1
  def show
    render json: @text_submission
  end

  # POST /text_submissions
  def create
    @text_submission = TextSubmission.new(text_submission_params)

    if @text_submission.save
      render json: @text_submission, status: :created, location: @text_submission
    else
      render json: @text_submission.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /text_submissions/1
  def update
    if @text_submission.update(text_submission_params)
      render json: @text_submission
    else
      render json: @text_submission.errors, status: :unprocessable_entity
    end
  end

  # DELETE /text_submissions/1
  def destroy
    @text_submission.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text_submission
      @text_submission = TextSubmission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def text_submission_params
      params.require(:text_submission).permit(:answer, :text_question_id)
    end
end
