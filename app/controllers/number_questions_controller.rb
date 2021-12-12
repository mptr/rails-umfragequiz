class NumberQuestionsController < ApplicationController
  before_action :set_number_question, only: [:show, :update, :destroy]

  # GET /number_questions
  def index
    @number_questions = NumberQuestion.all

    render json: @number_questions
  end

  # GET /number_questions/1
  def show
    render json: @number_question
  end

  # POST /number_questions
  def create
    @number_question = NumberQuestion.new(number_question_params)

    if @number_question.save
      render json: @number_question, status: :created, location: @number_question
    else
      render json: @number_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /number_questions/1
  def update
    if @number_question.update(number_question_params)
      render json: @number_question
    else
      render json: @number_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /number_questions/1
  def destroy
    @number_question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_number_question
      @number_question = NumberQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def number_question_params
      params.fetch(:number_question, {})
    end
end
