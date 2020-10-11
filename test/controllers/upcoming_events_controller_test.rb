# frozen_string_literal: true

require 'test_helper'

class UpcomingEventsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get upcoming_events_show_url
    assert_response :success
  end
end
