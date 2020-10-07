# frozen_string_literal: true

# app/controllers/concerns/secured.rb

module Secured
  extend ActiveSupport::Concern

  included do
    before_action :logged_in_using_omniauth?
  end

  def logged_in_using_omniauth?
    redirect_to '/', alert: 'You must log in to access the selected feature.' unless session[:userinfo].present?
  end
end
