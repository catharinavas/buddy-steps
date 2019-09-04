require 'test_helper'

class CommunitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get communities_index_url
  end

  test "should get show" do
    get communities_show_url
    assert_response :success
  end

end
