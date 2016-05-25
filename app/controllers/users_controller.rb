class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show]
	before_action :require_same_user, only: [:edit, :update]

	def index
		@users = User.paginate(page: params[:page], per_page: 4)
	end

	def show
		#@user = User.find(params[:id])
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
	end

	def new
		@user = User.new
	end

	def edit
		#@user = User.find(params[:id])	
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
		#@user = User.find(params[:id])
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

		def set_user
			@user = User.find(params[:id])
		end

		def require_same_user
			if current_user != @user
				flash[:danger] = "You can only edit your own account"
				redirect_to root_path
			end
		end
end