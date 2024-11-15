require "test_helper"

class Admin::TradersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_traders_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_traders_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_traders_edit_url
    assert_response :success
  end

  test "should get new" do
    get admin_traders_new_url
    assert_response :success
  end
end
