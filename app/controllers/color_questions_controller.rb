class ColorQuestionsController < ApplicationController
  before_action :set_color_question, only: [:show, :update, :destroy]

  # GET /color_questions
  def index
    @color_questions = ColorQuestion.all

    render json: @color_questions
  end

  # GET /color_questions/1
  def show
    render json: @color_question
  end

  # POST /color_questions
  def create
    @color_question = ColorQuestion.new(color_question_params)

    if @color_question.save
      render json: @color_question, status: :created, location: @color_question
    else
      render json: @color_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /color_questions/1
  def update
    if @color_question.update(color_question_params)
      render json: @color_question
    else
      render json: @color_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /color_questions/1
  def destroy
    @color_question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color_question
      @color_question = ColorQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def color_question_params
      params.fetch(:color_question, {})
    end
end
