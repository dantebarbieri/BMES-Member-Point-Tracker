# frozen_string_literal: true

# Controls basic CRUD for Events
class EventsController < ApplicationController
  include Secured
  include ExistingUser
  include AdminSecured

  helper_method :sort_column, :search_params

  # filter is set up in controllers/concerns/filterable and are handled by scopes in Event
  # sorting is set up in application_helper
  def index
    @events = if params[:search].present?
                Event.filter(filter_params).order(sort_column)
              else
                Event.order(sort_column)
              end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    ep = event_params
    ep[:participation_tracker_id] = nil
    puts ep
    @event = Event.new(ep)
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
    respond_to do |format|
      format.html
      format.js
    end
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

  def download
    @events = Event.all
    respond_to do |format|
      format.html
      format.csv { send_data @events.to_csv, filename: "events-#{Date.today}.csv" }
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_time, :event_type, :hidden, :attendance_points, :participation_tracker_id)
  end

  def filter_params
    params[:search].slice(:name, :start_time, :event_type, :hidden, :attendance_points, :participation_tracker_id)
  end

  # old way
  def search_params(p)
    p.permit(direction: [], sort: [], search: {})
  end

  def sort_column
    default = 'start_time desc'
    if params.key?('sort') && params.key?('direction')
      # prevent injection into .order
      order = params[:sort].uniq.zip(params[:direction]).select { |s, d| Event.column_names.include?(s) and %w[asc desc].include?(d) }
      # transform to something .order can use
      order.empty? ? default : order.map { |x, y| x + ' ' + y }.join(', ')
    else
      default
    end
  end
end
