require 'test_helper'

class InventoryCountsControllerTest < ActionController::TestCase
  test "should get coil" do
    get :coil
    assert_response :success
  end

  test "should get flatstock" do
    get :flatstock
    assert_response :success
  end

  test "should get sheathing" do
    get :sheathing
    assert_response :success
  end

end
