require 'test_helper'

class CancellationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cancellations_index_url
    assert_response :success
  end

end
