require 'test_helper'

class PreviousPointsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get previous_points_index_url
    assert_response :success
  end

  test "should get show" do
    get previous_points_show_url
    assert_response :success
  end

end
