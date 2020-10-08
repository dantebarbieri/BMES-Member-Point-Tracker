class MembereventsController < ApplicationController
  def index
    @events = Event.find_by_hidden(false).order(:date)
  end
end
