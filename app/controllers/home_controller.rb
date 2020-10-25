# frozen_string_literal: true

class HomeController < ApplicationController
  def show
    @member = Member.find_by_uid(session[:app_user]['uid']) if session[:app_user]
  end
end
