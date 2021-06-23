class UsersController < ApplicationController

	respond_to :json

	before_action :authenticate_user!
	before_action :verify_page_owner, only: [:update]

	def index
		@users = User.all
	end

	def show
		# (current_user.sign_in_count += 1) if current_user.sign_in_count == 1
		@user = User.find params[:id]

		@work = Work.new
	end

	def update
		@user = User.find params[:id]
		@work = Work.new
		[:name, :short_bio, :profession, :network, :workSelection].each do |attr|
			if params[attr]
				@user.update!(attr => params[attr])
			end
		end

		if params[:file]
			@user.update!(avatar: params[:file])
		else
			@user.update(avatar_params)
		end

		redirect_to user_path(id: current_user.id, editable: true)
	end

	private

	def avatar_params
		params[:user].permit(:avatar)
	end

	def verify_page_owner
		@user = User.find params[:id]
		redirect_to user_path(@user) if current_user != @user
	end

end
