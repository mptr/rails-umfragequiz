class RearrangeableQuestionsController < ApplicationController
  before_action :set_rearrangeable_question, only: [:show, :update, :destroy]

  # GET /rearrangeable_questions
  def index
    @rearrangeable_questions = RearrangeableQuestion.all

    render json: @rearrangeable_questions
  end

  # GET /rearrangeable_questions/1
  def show
    render json: @rearrangeable_question
  end

  # POST /rearrangeable_questions
  def create
    @rearrangeable_question = RearrangeableQuestion.new(rearrangeable_question_params)

    if @rearrangeable_question.save
      render json: @rearrangeable_question, status: :created, location: @rearrangeable_question
    else
      render json: @rearrangeable_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rearrangeable_questions/1
  def update
    if @rearrangeable_question.update(rearrangeable_question_params)
      render json: @rearrangeable_question
    else
      render json: @rearrangeable_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rearrangeable_questions/1
  def destroy
    @rearrangeable_question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rearrangeable_question
      @rearrangeable_question = RearrangeableQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rearrangeable_question_params
      params.fetch(:rearrangeable_question, {})
    end
end
