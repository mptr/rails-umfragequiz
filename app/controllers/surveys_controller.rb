class SurveysController < ApplicationController
  before_action :get_user
  before_action :set_survey, only: [:show, :update, :destroy]

  # creates a post object that's associated with the specific user instance from the get_user method
  def new
    @survey = @user.survey.build
  end

  # GET /surveys
  def index
    # wenn es über user aufgerufen wird, gib nur die surveys des users an
    if @user
      @surveys = @user.surveys
    # sonst gib alle verfügbaren surveys an (user-unabhängig)
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
    if @survey.update(survey_params)
      render json: @survey
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  # DELETE /surveys/1
  def destroy
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
