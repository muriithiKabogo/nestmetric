require 'test_helper'

class RiskycustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get riskycustomers_index_url
    assert_response :success
  end

end
