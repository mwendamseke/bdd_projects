class SubmissionsManagersController < ApplicationController
	def show
		@user = User.find params[:user_id]
		@submissions = @user.submissions
	end

end
