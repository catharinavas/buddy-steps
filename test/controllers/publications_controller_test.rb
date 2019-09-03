require 'test_helper'

class PublicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get publications_show_url
    assert_response :success
  end

end
