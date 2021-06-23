class Admin::JamsController < Admin::BaseController
  before_filter :load_event
  
  def index
    @jams = @event.jams.find(:all, :order => 'created_at DESC')
  end
  
  def show
    @jam = @event.jams.find_by_number(params[:id])
    raise NotFound unless @jam
  end
  
  def new
    @jam = @event.jams.build
    if params[:proposal_id].not.blank?
      @proposal = @event.presentation_proposals.find(params[:proposal_id])
      raise NotFound unless @proposal
      # I want to do this explicitly here (rather than via callback) so that it won't normally be used
      @jam.setup_from_proposal(@proposal)
    end
  end

  def create
    @jam = @event.jams.build
    if params[:proposal_id].not.blank?
      @proposal = @event.presentation_proposals.find(params[:proposal_id])
      raise NotFound unless @proposal
      # I want to do this explicitly here (rather than via callback) so that it won't normally be used
      @jam.setup_from_proposal(@proposal)
    end
    @jam.attributes = params[:jam]
    @jam.save!
    redirect_to [:admin,@event,@jam]
  end  

  before_filter :load_jam, :only => %w(edit update destroy)

  def edit
  end
  
  def update
    @jam.attributes = params[:jam]
    @jam.user_ids = params[:jam][:user_ids] || []
    @jam.save!
    redirect_to [:admin, @event, @jam]
  end
  
  def destroy
    @jam.destroy
    redirect_to admin_event_jams_path(@event)
  end

  private
  def load_event
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
  end
  def load_jam
    @jam = @event.jams.find_by_number(params[:id])
    raise NotFound unless @jam
  end
end