class StringQuestionsController < ApplicationController
  before_action :set_string_question, only: [:show, :update, :destroy]

  # GET /string_questions
  def index
    @string_questions = StringQuestion.all

    render json: @string_questions
  end

  # GET /string_questions/1
  def show
    render json: @string_question
  end

  # POST /string_questions
  def create
    @string_question = StringQuestion.new(string_question_params)

    if @string_question.save
      render json: @string_question, status: :created, location: @string_question
    else
      render json: @string_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /string_questions/1
  def update
    if @string_question.update(string_question_params)
      render json: @string_question
    else
      render json: @string_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /string_questions/1
  def destroy
    @string_question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_string_question
      @string_question = StringQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def string_question_params
      params.fetch(:string_question, {})
    end
end
