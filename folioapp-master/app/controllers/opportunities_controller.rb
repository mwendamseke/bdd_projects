class OpportunitiesController < ApplicationController

	def new
		@organisation = Organisation.find params[:organisation_id]
		@opportunity = @organisation.opportunities.new
	end

	def create
		@organisation = Organisation.find params[:organisation_id]
		@opportunity = @organisation.opportunities.create opportunity_params
		redirect_to organisation_path(@organisation)
	end

	private

	def opportunity_params
		params.require(:opportunity).permit(:title, :description, :image, :requirements)
	end


end
