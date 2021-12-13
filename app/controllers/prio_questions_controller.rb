class PrioQuestionsController < ApplicationController
  before_action :set_prio_question, only: [:show, :update, :destroy]

  # GET /prio_questions
  def index
    @prio_questions = PrioQuestion.all

    render json: @prio_questions
  end

  # GET /prio_questions/1
  def show
    render json: @prio_question
  end

  # POST /prio_questions
  def create
    @prio_question = PrioQuestion.new(prio_question_params)

    if @prio_question.save
      render json: @prio_question, status: :created, location: @prio_question
    else
      render json: @prio_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /prio_questions/1
  def update
    if @prio_question.update(prio_question_params)
      render json: @prio_question
    else
      render json: @prio_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /prio_questions/1
  def destroy
    @prio_question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prio_question
      @prio_question = PrioQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prio_question_params
      params.fetch(:prio_question, {})
    end
end
