class NumberSubmissionsController < ApplicationController
  before_action :set_number_submission, only: [:show, :update, :destroy]

  # GET /number_submissions
  def index
    @number_submissions = NumberSubmission.all

    render json: @number_submissions
  end

  # GET /number_submissions/1
  def show
    render json: @number_submission
  end

  # POST /number_submissions
  def create
    @number_submission = NumberSubmission.new(number_submission_params)

    if @number_submission.save
      render json: @number_submission, status: :created, location: @number_submission
    else
      render json: @number_submission.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /number_submissions/1
  def update
    if @number_submission.update(number_submission_params)
      render json: @number_submission
    else
      render json: @number_submission.errors, status: :unprocessable_entity
    end
  end

  # DELETE /number_submissions/1
  def destroy
    @number_submission.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_number_submission
      @number_submission = NumberSubmission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def number_submission_params
      params.fetch(:number_submission, {})
    end
end
