
require 'test_helper'

class AccomplishmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get accomplishments_index_url
    assert_response :success
  end

  test "should get show" do
    get accomplishments_show_url
    assert_response :success
  end


  test "should get edit" do
    get accomplishments_edit_url
    assert_response :success
  end


end