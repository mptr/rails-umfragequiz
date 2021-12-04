class TextQuestionsController < ApplicationController
  before_action :set_text_question, only: [:show, :update, :destroy]

  # GET /text_questions
  def index
    @text_questions = TextQuestion.all

    render json: @text_questions
  end

  # GET /text_questions/1
  def show
    render json: @text_question
  end

  # POST /text_questions
  def create
    @text_question = TextQuestion.new(text_question_params)

    if @text_question.save
      render json: @text_question, status: :created, location: @text_question
    else
      render json: @text_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /text_questions/1
  def update
    if @text_question.update(text_question_params)
      render json: @text_question
    else
      render json: @text_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /text_questions/1
  def destroy
    @text_question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text_question
      @text_question = TextQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def text_question_params
      params.fetch(:text_question, {})
    end
end
