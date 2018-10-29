require 'test_helper'

class FlagsControllerTest < ActionDispatch::IntegrationTest
  test "should get flags" do
    get flags_flags_url
    assert_response :success
  end

  test "should get flagged" do
    get flags_flagged_url
    assert_response :success
  end

end
