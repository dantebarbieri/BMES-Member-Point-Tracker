class UpcomingEventsController < ApplicationController
  include Secured
  include ExistingUser

  def show
    @events = Event.order(:date).find_by_hidden(false)
  end
end
