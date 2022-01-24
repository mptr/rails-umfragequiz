class UsersController < ApplicationController
	before_action :set_user, only: %i[show update destroy]

	# GET /users
	def index
		@users = User.all

		render json: @users
	end

	# GET /users/1
	def show
		if @user.nil?
			render :nothing => true, status: if params[:id] == 'self' then 204 else 403 end
			return
		end
		# user can only show self
		require_requester_to_be(@user) and return

		render json: @user
	end

	# POST /users
	def create
		puts "SIGNUP: #{@requester_username}  #{@requester_email}"
		@user = User.new(username: @requester_username, email: @requester_email)

		if @user.save
			render json: @user, status: :created, location: @user
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /users/1
	def update
		# require_requester ?
		if @user.update(user_params)
			render json: @user
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	# DELETE /users/1
	def destroy
		@user.destroy
	end

	private

	# Use callbacks to share common setup or constraints between actions.
	def set_user
		if params[:id] == 'self'
			@user = User.where(email: @requester_email).first
		else
			@user = User.find(params[:id])
		end
	end

	# Only allow a list of trusted parameters through.
	def user_params
		params.require(:user).permit
	end
end
