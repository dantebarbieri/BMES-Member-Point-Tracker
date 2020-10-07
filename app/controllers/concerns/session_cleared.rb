# frozen_string_literal: true

# app/controllers/concerns/session_cleared

module SessionCleared
  extend ActiveSupport::Concern

  included do
    before_action :clear_session
  end

  def clear_session
    reset_session
    puts 'CLEARED THE SESSION APPARENTLY'
  end
end
