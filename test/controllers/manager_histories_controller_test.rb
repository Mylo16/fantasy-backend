require "test_helper"

class ManagerHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manager_histories_index_url
    assert_response :success
  end

  test "should get show" do
    get manager_histories_show_url
    assert_response :success
  end

  test "should get create" do
    get manager_histories_create_url
    assert_response :success
  end

  test "should get update" do
    get manager_histories_update_url
    assert_response :success
  end

  test "should get destroy" do
    get manager_histories_destroy_url
    assert_response :success
  end
end
