class MultipleChoicheQuestionsController < ApplicationController
  before_action :set_multiple_choiche_question, only: [:show, :update, :destroy]

  # GET /multiple_choiche_questions
  def index
    @multiple_choiche_questions = MultipleChoicheQuestion.all

    render json: @multiple_choiche_questions
  end

  # GET /multiple_choiche_questions/1
  def show
    render json: @multiple_choiche_question
  end

  # POST /multiple_choiche_questions
  def create
    @multiple_choiche_question = MultipleChoicheQuestion.new(multiple_choiche_question_params)

    if @multiple_choiche_question.save
      render json: @multiple_choiche_question, status: :created, location: @multiple_choiche_question
    else
      render json: @multiple_choiche_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /multiple_choiche_questions/1
  def update
    if @multiple_choiche_question.update(multiple_choiche_question_params)
      render json: @multiple_choiche_question
    else
      render json: @multiple_choiche_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /multiple_choiche_questions/1
  def destroy
    @multiple_choiche_question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multiple_choiche_question
      @multiple_choiche_question = MultipleChoicheQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def multiple_choiche_question_params
      params.require(:multiple_choiche_question).permit(:upTo)
    end
end
