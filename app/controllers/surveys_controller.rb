class SurveysController < ApplicationController
  before_action :get_user
  before_action :set_survey, only: [:show, :update, :destroy]

  # creates a post object that's associated with the specific user instance from the get_user method
  def new
    @survey = @user.survey.build
  end

  # GET /surveys
  def index
    # if it is called via user, only show the users surveys
    if @user
      @surveys = @user.surveys
    # otherwise show all available surveys (user-independent)
    else
      @surveys = Survey.all
    end

    render json: @surveys
  end

  # GET /surveys/1
  def show
    render json: @survey
  end

  # POST /surveys
  def create
    if @user == nil
      render :nothing => true, :status => 400
      return
    end

    @survey = Survey.new(survey_params)
    # puts "######################################"
    # puts survey_params
    # survey_params[:questions].each_with_index{|val, index|
    #   @survey.questions.append(Question.new(val))
    # }
    # @survey.questions.append(survey_params[:questions])
    @user.surveys.append(@survey)

    if @survey.save
      render json: @survey, status: :created, location: @survey
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /surveys/1
  def update
    # only survey owner can update a survey
    require_requester_to_be(@survey.user)

    if @survey.update(survey_params)
      render json: @survey
      return
    else
      render json: @survey.errors, status: :unprocessable_entity
      return
    end
  end

  # DELETE /surveys/1
  def destroy
    # only survey owner can destroy a survey
    require_requester_to_be(@survey.user)
    
    @survey.destroy
  end

  private
    def get_user
      if params[:user_id] == nil
        @user = nil
      else
        @user = User.find(params[:user_id])
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      if @user
        @survey = @user.surveys.find(params[:id])
      else
        @survey = Survey.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def survey_params
      # params.require(:survey).permit(:name, :from_date, :to_date, :user_id, questions:[:optional, :description, :survey_id, :type, :answer_options, :random_order, :up_to, :questions, :from, :to, :step])
      params.require(:survey).permit(:name, :from_date, :to_date, :user_id, questions:[:optional, :description])
    end

    # def question_params(q_data)
    #   permits = [:optional, :description, :survey_id, :type] # general question params
    #   case q_data[:type]
    #     when 'SingleChoiceQuestion'
    #       permits.append(:answer_options, :random_order)
    #     when 'MultipleChoiceQuestion'
    #       permits.append(:up_to, :answer_options, :random_order)
    #     when "LikertQuestion"
    #       permits.append(:questions, :answer_options, :random_order)
    #     when "SliderQuestion", "NumberQuestion"
    #       permits.append(:from, :to, :step)
    #   end
    #   q_data.permit(permits)
    # end
end
