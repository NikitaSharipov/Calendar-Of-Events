class EventsController < ApplicationController

  def index
    @events = Event.where(user: current_user)
  end

  def all
    @events = Event.all
    render 'events/index'
  end

  def new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to events_path, notice: 'You have added an event'
    else
      redirect_to events_path, notice: @event.errors.full_messages.to_s
    end
  end

  private

  def event_params
    params.permit(:title, :date)
  end

end
