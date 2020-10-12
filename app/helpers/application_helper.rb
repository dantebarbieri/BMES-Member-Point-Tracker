# frozen_string_literal: true

module ApplicationHelper
  
  # Makes titles have nifty arrows next to them if sorted
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column && sort_direction == "asc" ? "fa fa-arrow-up" : "fa fa-arrow-down"
    css_class = column == sort_column ? css_class : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.permit(column).merge(:sort => column, :direction => direction), {:class => css_class}
  end
end
