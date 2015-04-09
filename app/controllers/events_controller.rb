class EventsController < ApplicationController
  respond_to :html

  before_filter :authenticate_speaker!, only: [:new, :create, :edit, :update]

  def index
    @events = Event.newest_first.approved
  end

  def new
    @event = Event.new default_event_params
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
    params.require(:event).permit(
      :school_id,
      :date,
      :name,
      :url,
      :public_email,
      :cover_image,
      :delete_cover_image,
      :details
    )
  end

  def default_event_params
    params
      .fetch(:event, {})
      .permit(:school_id)
      .merge(public_email: current_speaker.email, date: 1.week.from_now.to_date)
  end
end
