class PointsController < ApplicationController
  include Secured
  include ExistingUser


  def events 
    @member = Member.find_by_email(session[:app_user]['email']) 
  end 

  def manual_points
    @member = Member.find_by_email(session[:app_user]['email'])
  end

  def accomplishments
    @member = Member.find_by_email(session[:app_user]['email'])
  end
end
