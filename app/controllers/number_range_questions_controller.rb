class NumberRangeQuestionsController < ApplicationController
  before_action :set_number_range_question, only: [:show, :update, :destroy]

  # GET /number_range_questions
  def index
    @number_range_questions = NumberRangeQuestion.all

    render json: @number_range_questions
  end

  # GET /number_range_questions/1
  def show
    render json: @number_range_question
  end

  # POST /number_range_questions
  def create
    @number_range_question = NumberRangeQuestion.new(number_range_question_params)

    if @number_range_question.save
      render json: @number_range_question, status: :created, location: @number_range_question
    else
      render json: @number_range_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /number_range_questions/1
  def update
    if @number_range_question.update(number_range_question_params)
      render json: @number_range_question
    else
      render json: @number_range_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /number_range_questions/1
  def destroy
    @number_range_question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_number_range_question
      @number_range_question = NumberRangeQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def number_range_question_params
      params.fetch(:number_range_question, {})
    end
end
