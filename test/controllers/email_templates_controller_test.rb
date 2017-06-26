require 'test_helper'

class EmailTemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get email_templates_new_url
    assert_response :success
  end

end
