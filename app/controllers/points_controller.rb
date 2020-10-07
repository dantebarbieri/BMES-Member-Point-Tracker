class PointsController < ApplicationController
    include Secured
    include ExistingUser
    
    def events
    end
  
    def manual_points
      @member.manual_points = Points.all
    end
  
    def accomplishments
      @member.accomplishments = Points.all
    end
  end