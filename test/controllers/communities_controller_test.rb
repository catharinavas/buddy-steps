require 'test_helper'

class CommunitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get communities_show_url
    assert_response :success
  end

end
