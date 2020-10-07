# frozen_string_literal: true

require 'test_helper'

class GiveAccomplishmentsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get give_accomplishments_index_url
    assert_response :success
  end

  test 'should get show' do
    get give_accomplishments_show_url
    assert_response :success
  end

  test 'should get new' do
    get give_accomplishments_new_url
    assert_response :success
  end

  test 'should get edit' do
    get give_accomplishments_edit_url
    assert_response :success
  end

  test 'should get delete' do
    get give_accomplishments_delete_url
    assert_response :success
  end
end
