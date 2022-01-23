class QuestionsController < ApplicationController
  before_action :get_survey
  before_action :set_question, only: [:show, :update, :destroy]

  # GET /questions
  def index
    @questions = @survey.questions
    render json: @questions
  end

  # GET /questions/1
  def show
    render json: @question
  end

  # POST /questions
  def create
    render :nothing => true, :status => 405
  end

  # PATCH/PUT /questions/1
  def update
    render :nothing => true, :status => 405
  end

  # DELETE /questions/1
  def destroy
    render :nothing => true, :status => 405
  end

  private
    def get_survey
      @survey = Survey.find(params[:survey_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = @survey.questions.find(params[:id])
    end
end
