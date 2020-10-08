class UpcomingEventsController < ApplicationController
  def show
    @events = Event.find_by_hidden(false).order(:date)
  end
end
