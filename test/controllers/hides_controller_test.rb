require 'test_helper'

class HidesControllerTest < ActionDispatch::IntegrationTest
  test "should get hides" do
    get hides_hides_url
    assert_response :success
  end

  test "should get hidden" do
    get hides_hidden_url
    assert_response :success
  end

end
