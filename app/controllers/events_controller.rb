class EventsController < ApplicationController
  before_filter :authenticate_speaker!
  respond_to :html

  def index
    @events = Event.newest_first.approved
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_speaker.events.create event_params

    respond_with @event
  end

  def show
    @event = Event.find params[:id]
  end

  def edit
    @event = current_speaker.events.find params[:id]
  end

  def update
    @event = current_speaker.events.find params[:id]
    @event.update_attributes event_params

    respond_with @event
  end

  private

  def event_params
    params.require(:event).permit(:school_id, :date, :name, :cover_image, :details)
  end
end
