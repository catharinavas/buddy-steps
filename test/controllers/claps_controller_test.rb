require 'test_helper'

class ClapsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get claps_update_url
    assert_response :success
  end

end
