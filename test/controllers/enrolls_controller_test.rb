require 'test_helper'

class EnrollsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get enrolls_destroy_url
    assert_response :success
  end

end
