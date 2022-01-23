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
    # require_requester_to_be(@question.survey.user)

    # @question = Question.new(question_params)
    # @survey.questions.append(@question)

    # if @question.save
    #   render json: @question, status: :created
    # else
    #   render json: @question.errors, status: :unprocessable_entity
    # end
  end

  # PATCH/PUT /questions/1
  def update
    render :nothing => true, :status => 405
    # require_requester_to_be(@question.survey.user)

    # if @question.update(question_params)
    #   render json: @question
    # else
    #   render json: @question.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /questions/1
  def destroy
    render :nothing => true, :status => 405
    # require_requester_to_be(@question.survey.user)
    
    # @question.destroy
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
          permits.append(:answer_options, :random_order)
        when 'MultipleChoiceQuestion'
          permits.append(:up_to, :answer_options, :random_order)
        when "LikertQuestion"
          permits.append(:questions, :answer_options, :random_order)
        when "SliderQuestion", "NumberQuestion"
          permits.append(:from, :to, :step)
      end
      params.require(:question).permit(permits)
    end
end
