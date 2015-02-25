require 'test_helper'

class PodAssemblyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
