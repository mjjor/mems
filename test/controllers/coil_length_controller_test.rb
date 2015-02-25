require 'test_helper'

class CoilLengthControllerTest < ActionController::TestCase
  test "should get lengthNew" do
    get :lengthNew
    assert_response :success
  end

end
