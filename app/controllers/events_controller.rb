class EventsController < ApplicationController

  def index
    @events = Event.where(user: current_user)
  end

end
