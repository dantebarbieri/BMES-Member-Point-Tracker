# frozen_string_literal: true

class UpcomingEventsController < ApplicationController
  include Secured
  include ExistingUser

  def show
    @events = Event.order(:start_time)
  end
end
