class EventsController < ApplicationController
  def show
    @event = Event.published.find_by_tag(params[:id], :include => {:jams => :presenters})
    raise NotFound unless @event
    @total_tweets = @event.tweets.count
    @latest_tweets = @event.tweets.latest(5).all
    @more_tweets = @event.tweets.count > @latest_tweets.length
    @all_photos = @event.flickr_photos.all(:order => "created_at DESC")
    @featured_videos = @event.viddler_videos.featured.all :order => "created_at DESC"
    @all_videos = @event.viddler_videos.all(:order => "jam_id ASC")
    @published_jams = @event.jams.published.all(:include => {:presenters => :user})
    if @event.upcoming?
      @previous_event = @event.previous
      @featured_photos = @event.flickr_photos.featured.all :order => "created_at DESC"
      if @featured_photos.empty? && @previous_event
        @photos_from_previous_event = true
        @featured_photos = @previous_event.flickr_photos.featured.all :order => "created_at DESC"
      end
      render :action => "show_upcoming"
    else
      @featured_photos = @event.flickr_photos.featured.all :order => "created_at DESC"
      @photos = @event.flickr_photos.all :order => "created_at DESC", :limit => 10
      render :action => "show"
    end
  end
  def past
    @past_events = Event.published.past
    @upcoming_events = Event.published.upcoming
  end
end