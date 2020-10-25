# frozen_string_literal: true

# heavily modified from: http://railscasts.com/episodes/228-sortable-table-columns?autoplay=true

module ApplicationHelper
  # Makes titles have nifty arrows next to them if sorted
  def sortable(column, title = nil)
    title ||= column.titleize

    if params.key?('sort') && params.key?('direction')
      s_i = params[:sort].index(column)
      new_direction = Array.new(params[:direction])
      new_sort = Array.new(params[:sort])
      if new_sort.include?(column)
        if new_direction[s_i] == 'asc'
          css_class = 'fa fa-arrow-up'
          new_direction[s_i] = 'desc'
        else
          css_class = 'fa fa-arrow-down'
          new_direction.delete_at(s_i)
          new_sort.delete_at(s_i)
        end
      else
        new_sort.push(column)
        new_direction.push('asc')
        css_class = nil
      end
      link_to title, search_params(params.merge(sort: new_sort, direction: new_direction)), { class: css_class }
    else
      css_class = nil
      link_to title, search_params(params.merge(sort: [column], direction: ['asc'])), { class: css_class }
    end
  end
end
