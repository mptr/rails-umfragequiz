class NpsQuestionsController < ApplicationController
  before_action :set_nps_question, only: [:show, :update, :destroy]

  # GET /nps_questions
  def index
    @nps_questions = NpsQuestion.all

    render json: @nps_questions
  end

  # GET /nps_questions/1
  def show
    render json: @nps_question
  end

  # POST /nps_questions
  def create
    @nps_question = NpsQuestion.new(nps_question_params)

    if @nps_question.save
      render json: @nps_question, status: :created, location: @nps_question
    else
      render json: @nps_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /nps_questions/1
  def update
    if @nps_question.update(nps_question_params)
      render json: @nps_question
    else
      render json: @nps_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /nps_questions/1
  def destroy
    @nps_question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nps_question
      @nps_question = NpsQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nps_question_params
      params.fetch(:nps_question, {})
    end
end
