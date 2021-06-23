class SubmissionsController < ApplicationController

	before_action :authenticate_user!
	before_action :verify_organisation, only: [:create, :index]

	def new
		@opportunity = Opportunity.find params[:opportunity_id]
		@submission = @opportunity.submissions.new
		
		@available_works = current_user.works.all.map {|work| ["#{work.collection.title}: #{work.title}", work.id] }
	end

	def create
		@opportunity = Opportunity.find params[:opportunity_id]
		work = Work.find params[:submission].permit(:work)["work"]
		@organisation = Organisation.find params[:organisation_id]
		submission = @opportunity.submissions.create message: params[:submission].permit(:message)["message"], work: work, user: current_user, organisation: @organisation 
		submission.save!
		redirect_to "/organisations/#{@organisation.id}"
	end

	def index
		@opportunity = Opportunity.find params[:opportunity_id]
		@submissions = @opportunity.submissions
		@organisation = Organisation.find params[:organisation_id]
	end

	private

	def verify_organisation
		@organisation = Organisation.find params[:organisation_id]
		redirect_to organisation_path(@organisation) if !@organisation.users.include? current_user
	end

end
