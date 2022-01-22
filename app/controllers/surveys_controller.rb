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
    @survey = Survey.new(survey_params)
    @user.survey.append(@survey)

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
      params.require(:survey).permit(:name, :from_date, :to_date, :user_id)
    end
end
