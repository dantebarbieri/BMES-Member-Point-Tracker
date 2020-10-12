# frozen_string_literal: true

# Controls basic CRUD for Events
class EventsController < ApplicationController
  include Secured
  include ExistingUser
  include AdminSecured

  helper_method :sort_column, :sort_direction

  def index
    @events = Event.search(params).order(sort_column + " " + sort_direction)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = 'Event Created Successfully'
      redirect_to(events_path)
    else
      flash[:alert] = 'Event Not Created Successfully'
      render('new')
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def postpone
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    session[:return_to] ||= request.referer
    if @event.update_attributes(event_params)
      flash[:notice] = 'Event Updated Successfully'
      redirect_to(events_path(@event))
    else
      flash[:alert] = 'Event Failed to Update Successfully'
      redirect_to session.delete(:return_to)
    end
  end

  def delete
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = 'Event Destroyed Successfully'
    redirect_to(events_path)
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :time, :event_type, :hidden, :attendance_points, :direction, :sort)
  end

  def sort_column
    Event.column_names.include?(params[:sort]) ? params[:sort] : "date"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
