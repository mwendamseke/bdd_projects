class RsvpsController < ApplicationController
  before_filter :login_required

  def show
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
    @rsvp = current_user.rsvp_for(@event)
    render :action => (@rsvp ? :show : :new)
  end
  
  def pike
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
    @rsvp = current_user.rsvp_for(@event)
    redirect_to event_rsvp_path(@event) unless @rsvp
  end
  
  def update
    @event = Event.find_by_tag(params[:event_id])
    raise NotFound unless @event
    if @event.full?
      redirect_to event_path(:id => @event, :event_full => true)
    else
      current_user.rsvps.create(:event => @event)
      redirect_to event_rsvp_path(@event)
    end
  end
  
  def destroy
    event = Event.find_by_tag(params[:event_id])
    raise NotFound unless event
    if rsvp = current_user.rsvp_for(event)
      rsvp.destroy
    end
    redirect_to event_path(event)
  end
end
