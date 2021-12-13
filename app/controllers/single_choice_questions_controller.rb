class SingleChoiceQuestionsController < ApplicationController
  before_action :set_single_choice_question, only: [:show, :update, :destroy]

  # GET /single_choice_questions
  def index
    @single_choice_questions = SingleChoiceQuestion.all

    render json: @single_choice_questions
  end

  # GET /single_choice_questions/1
  def show
    render json: @single_choice_question
  end

  # POST /single_choice_questions
  def create
    @single_choice_question = SingleChoiceQuestion.new(single_choice_question_params)

    if @single_choice_question.save
      render json: @single_choice_question, status: :created, location: @single_choice_question
    else
      render json: @single_choice_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /single_choice_questions/1
  def update
    if @single_choice_question.update(single_choice_question_params)
      render json: @single_choice_question
    else
      render json: @single_choice_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /single_choice_questions/1
  def destroy
    @single_choice_question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_single_choice_question
      @single_choice_question = SingleChoiceQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def single_choice_question_params
      params.fetch(:single_choice_question, {})
    end
end
