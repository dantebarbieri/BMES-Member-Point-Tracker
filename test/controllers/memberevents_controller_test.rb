# frozen_string_literal: true

require 'test_helper'

class MembereventsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get memberevents_index_url
    assert_response :success
  end
end
