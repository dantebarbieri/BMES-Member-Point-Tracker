require 'test_helper'

class PreviousPointsControllerTest < ActionDispatch::IntegrationTest
  test "should get accomplishments" do
    get previous_points_accomplishments_url
    assert_response :success
  end

  test "should get manual_points" do
    get previous_points_manual_points_url
    assert_response :success
  end

  test "should get events" do
    get previous_points_events_url
    assert_response :success
  end

  test "should get index" do
    get previous_points_index_url
    assert_response :success
  end

  test "should get show" do
    get previous_points_show_url
    assert_response :success
  end

end
