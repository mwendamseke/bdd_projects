class CollectionsController < ApplicationController

	before_action :authenticate_user!
	before_action :verify_page_owner, only: [:new, :create, :update]


	def index
		@user = User.find params[:user_id]
	end

	def show
		@user = User.find params[:user_id]
		@collection = @user.collections.find params[:id]
	end

	def new
		@user = User.find params[:user_id]
		@collection = @user.collections.new
	end

	def create
		@user = User.find params[:user_id]
		if params[:createNewCollection]
			@user.collections.create! title: "New Collection", description: "Enter your collection description here"
		# else 
			# @collection = @user.collections.create collection_params
		end
		render "index"
	end

	def update
		@collection = Collection.find params[:id]
		[:title, :description].each do |attr|
			if params[attr]
				@collection.update!(attr => params[attr])
			end
		end
		# raise 'Hello'
		if params[:file]
			@collection.update!(image: params[:file])
		end

		render json: {success: 200}
	end

	def destroy
		@collection = Collection.find params[:id]
		@collection.destroy!
		render json: {success: 200}
	end

	private

	def collection_params
		params.require(:collection).permit(:title, :description, :image)
	end

	def verify_page_owner
		@user = User.find params[:user_id]
		redirect_to user_path(@user) if current_user != @user 
	end

end
