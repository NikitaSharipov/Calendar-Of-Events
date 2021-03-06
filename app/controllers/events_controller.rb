class EventsController < ApplicationController

  def index
    @events = Services::ServiceCopiedEventInstancies.new(current_user).copied_event_instancies
  end

  def all
    #@events = Event.all
    @events = Services::ServiceCopiedEventInstancies.new(User.all).copied_event_instancies
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

  def edit
    event
  end

  def update
    if event.update(params[:event].permit(:title, :date, :repeatable))
      redirect_to events_path, notice: 'You have updated an event'
    else
      redirect_to events_path, notice: @event.errors.full_messages.to_s
    end
  end

  def show
    event
  end

  def destroy
    event.destroy
  end

  private

  def event_params
    params.permit(:title, :date, :repeatable)
  end

  def event
    @event = Event.find(params[:id])
  end

end
