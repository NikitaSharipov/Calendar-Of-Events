class EventsController < ApplicationController

  def index
    @events = Event.where(user: current_user)
  end

  def all
    @events = Event.all
    render 'events/index'
  end

end
