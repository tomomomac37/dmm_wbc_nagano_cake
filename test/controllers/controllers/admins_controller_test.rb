require 'test_helper'

class Controllers::AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get items" do
    get controllers_admins_items_url
    assert_response :success
  end

  test "should get index" do
    get controllers_admins_index_url
    assert_response :success
  end

  test "should get new" do
    get controllers_admins_new_url
    assert_response :success
  end

  test "should get create" do
    get controllers_admins_create_url
    assert_response :success
  end

  test "should get update" do
    get controllers_admins_update_url
    assert_response :success
  end

  test "should get show" do
    get controllers_admins_show_url
    assert_response :success
  end

  test "should get edit" do
    get controllers_admins_edit_url
    assert_response :success
  end

end
