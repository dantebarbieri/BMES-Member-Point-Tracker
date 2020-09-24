require 'test_helper'

class SemesterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get semester_index_url
    assert_response :success
  end

  test "should get show" do
    get semester_show_url
    assert_response :success
  end

  test "should get edit" do
    get semester_edit_url
    assert_response :success
  end

  test "should get delete" do
    get semester_delete_url
    assert_response :success
  end

  test "should get new" do
    get semester_new_url
    assert_response :success
  end

end
