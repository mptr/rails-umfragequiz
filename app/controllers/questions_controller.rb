class QuestionsController < ApplicationController
  before_action :get_survey
  before_action :set_question, only: [:show, :update, :destroy]

  # GET /questions
  def index
    # @questions = Question.all
    @questions = @survey.questions
    render json: @questions
  end

  # GET /questions/1
  def show
    # @question["type"] = "adhjkafdjoil"
    render json: @question
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    @survey.questions.append(@question)

    if @question.save
      render json: @question, status: :created
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
  end

  private
    def get_survey
      @survey = Survey.find(params[:survey_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = @survey.questions.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      permits = [:optional, :description, :survey_id, :type] # general question params
      case params[:type]
        when 'SingleChoiceQuestion'
          permits.append(:answer_options)
        when 'MultipleChoiceQuestion'
          permits.append(:up_to, :answer_options)
        when "LikertQuestion"
          permits.append(:questions, :answer_options)
        when "SliderQuestion", "NumberQuestion"
          permits.append(:from, :to, :step)
      end
      params.require(:question).permit(permits)
    end
end
