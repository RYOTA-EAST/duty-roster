require 'test_helper'

class DutysControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get dutys_index_url
    assert_response :success
  end
end
