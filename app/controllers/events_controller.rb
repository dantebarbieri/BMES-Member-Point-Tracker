# frozen_string_literal: true

# Controls basic CRUD for Events
class EventsController < ApplicationController
  include Secured
  include ExistingUser
  include AdminSecured

  helper_method :sort_column, :search_params

  def index
    if params[:search].present?
      @events = Event.filter(filter_params).order(sort_column)
    else
      @events = Event.order(sort_column)
    end
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

  private

  def event_params
    params.require(:event).permit(:name, :date, :time, :event_type, :hidden, :attendance_points)
  end

  def filter_params
    puts params[:search][:date].to_s
    puts params[:search][:time].to_s
    puts params[:search][:event_type].to_s
    puts params[:search][:hidden].to_s
    puts "sdfsdfdsfsfds"
    params[:search].slice(:name, :date, :time, :event_type, :hidden, :attendance_points)
  end

  # old way
  def search_params(p)
    p.permit(:direction => [], :sort => [], :search => {})
  end

  def sort_column
    default = "date desc"
    if params.key?("sort") and params.key?("direction")
      # prevent injection into .order
      order = params[:sort].uniq.zip(params[:direction]).select { |s, d| Event.column_names.include?(s) and %w[asc desc].include?(d) }
      # transform to something .order can use
      order.empty? ? default : order.map { |x,y| x + ' ' + y }.join(', ')
    else
      default
    end
  end
end
