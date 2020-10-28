# frozen_string_literal: true

# from https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/

module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params)
      results = where(nil)
      filtering_params.each do |key, value|
        results = results.public_send("filter_by_#{key}", value) if value.present?
      end
      results
    end
  end
end
