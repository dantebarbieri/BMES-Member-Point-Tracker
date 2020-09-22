class EventsController < ApplicationController
  def index
    @events = Event.order(:date)
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
      flash[:notice] = "Event Created Successfully"
      redirect_to(events_path)
    else
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
      flash[:notice] = "Event Updated Successfully"
      redirect_to(events_path(@event))
    else
      redirect_to session.delete(:return_to)
    end
  end

  def delete
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Event Destroyed Successfully"
    redirect_to(events_path)
  end

  private
  def event_params
    params.require(:event).permit(:name, :date, :time, :event_type, :attendance_points)
  end
end
