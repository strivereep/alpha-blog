class UsersController < ApplicationController
	
	def index
		@users = User.all	
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])	
	end

	def create
		#debugger
		@user = User.new(users_params)
		if @user.save
			flash[:success] = "Welcome to the alpha blog #{@user.username}"
			redirect_to articles_path
		else
			render 'new'
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(users_params)
			flash[:success] = "Your account was upadated successfully"
			redirect_to articles_path
		else
			render 'edit'
		end
	end

	private
		def users_params
			params.require(:user).permit(:username, :email, :password)
		end
end