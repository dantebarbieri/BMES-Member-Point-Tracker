# frozen_string_literal: true

module EventsHelper
  def name_from_search_params
    params[:search][:name] if params[:search].present?
  end

  def date_from_search_params
    params[:search][:date] if params[:search].present?
  end

  def time_from_search_params
    params[:search][:time] if params[:search].present?
  end

  def hidden_from_search_params
    params[:search][:hidden] if params[:search].present?
  end

  def event_type_from_search_params
    params[:search][:event_type] if params[:search].present?
  end

  def attendance_points_from_search_params
    params[:search][:attendance_points] if params[:search].present?
  end
end
