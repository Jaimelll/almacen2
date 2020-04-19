require 'test_helper'

class VariablesControllerTest < ActionDispatch::IntegrationTest
  test "should get form" do
    get variables_form_url
    assert_response :success
  end

end
