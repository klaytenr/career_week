require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

end
