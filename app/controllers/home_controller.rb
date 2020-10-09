# frozen_string_literal: true

class HomeController < ApplicationController
  def show
    if session[:app_user]
      @member = Member.find_by_uid(session[:app_user]['uid'])
    end
  end
end
