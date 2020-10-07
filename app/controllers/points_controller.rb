class PointsController < ApplicationController
    include Secured
    include ExistingUser
  
    @member = Member.find_by_email(session[:app_user]['email'])
  
    def events
    end
  
    def manual_points
    end
  
    def accomplishments
    end
  end