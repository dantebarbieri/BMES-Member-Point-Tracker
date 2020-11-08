# frozen_string_literal: true

class AboutController < ApplicationController
  include Secured
  include ExistingUser
  include AdminSecured

  def index; end
end
