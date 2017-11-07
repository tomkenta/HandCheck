require 'test_helper'

class HandsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hands_index_url
    assert_response :success
  end

end