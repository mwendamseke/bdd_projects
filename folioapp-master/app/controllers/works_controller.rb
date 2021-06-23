class WorksController < ApplicationController

	before_action :authenticate_user!
	before_action :verify_page_owner, only: [:new, :create, :update]

	def new
		@upload_type = params[:upload_type]
		@user = User.find params[:user_id]
		@collection = @user.collections.find params[:collection_id]
		@new_work = @collection.works.new
	end

	def create
		@user = User.find params[:user_id]
		@collection = @user.collections.find params[:collection_id]
		@work = @collection.works.create work_params
		# raise 'Hello'
		redirect_to user_collection_path(@user, @collection)
	end

	private

	def work_params
		params.require(:work).permit(:image, :title, :medium_names, :genre_names, :caption, :text)
	end

	def verify_page_owner
		@user = User.find params[:user_id]
		redirect_to user_path(@user) if current_user != @user
	end

end

