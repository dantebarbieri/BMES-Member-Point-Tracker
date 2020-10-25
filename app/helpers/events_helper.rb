# frozen_string_literal: true

module EventsHelper
  def name_from_search_params
    if params[:search].present?
      params[:search][:name]
    end
  end
  def date_from_search_params
    if params[:search].present?
      params[:search][:date]
    end
  end
  def time_from_search_params
    if params[:search].present?
      params[:search][:time]
    end
  end
  def hidden_from_search_params
    if params[:search].present?
      params[:search][:hidden]
    end
  end
  def event_type_from_search_params
    if params[:search].present?
      params[:search][:event_type]
    end
  end
  def attendance_points_from_search_params
    if params[:search].present?
      params[:search][:attendance_points]
    end
  end
end
