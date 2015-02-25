require 'test_helper'

class CoilWidthControllerTest < ActionController::TestCase
  test "should get widthNew" do
    get :widthNew
    assert_response :success
  end

  test "should get widthCalc" do
    get :widthCalc
    assert_response :success
  end

  test "should get widthResult" do
    get :widthResult
    assert_response :success
  end

end
