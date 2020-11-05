# frozen_string_literal: true

require 'test_helper'

class PointsControllerTest < ActionDispatch::IntegrationTest
  test 'should get events' do
    get points_events_url
    assert_response :success
  end

  test 'should get manual_points' do
    get points_manual_points_url
    assert_response :success
  end

  test 'should get accomplishments' do
    get points_accomplishments_url
    assert_response :success
  end
end
