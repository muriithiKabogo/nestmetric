require 'test_helper'

class FailedChargesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get failed_charges_index_url
    assert_response :success
  end

end
