require 'test_helper'

class EndpointControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
