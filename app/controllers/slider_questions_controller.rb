class SliderQuestionsController < ApplicationController
  before_action :set_slider_question, only: [:show, :update, :destroy]

  # GET /slider_questions
  def index
    @slider_questions = SliderQuestion.all

    render json: @slider_questions
  end

  # GET /slider_questions/1
  def show
    render json: @slider_question
  end

  # POST /slider_questions
  def create
    @slider_question = SliderQuestion.new(slider_question_params)

    if @slider_question.save
      render json: @slider_question, status: :created, location: @slider_question
    else
      render json: @slider_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /slider_questions/1
  def update
    if @slider_question.update(slider_question_params)
      render json: @slider_question
    else
      render json: @slider_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /slider_questions/1
  def destroy
    @slider_question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slider_question
      @slider_question = SliderQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def slider_question_params
      params.fetch(:slider_question, {})
    end
end
