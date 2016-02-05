require 'test_helper'

class U2FRegistrationsControllerTest < ActionController::TestCase
  setup do
    @u2_f_registration = u2_f_registrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:u2_f_registrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create u2_f_registration" do
    assert_difference('U2FRegistration.count') do
      post :create, u2_f_registration: {  }
    end

    assert_redirected_to u2_f_registration_path(assigns(:u2_f_registration))
  end

  test "should show u2_f_registration" do
    get :show, id: @u2_f_registration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @u2_f_registration
    assert_response :success
  end

  test "should update u2_f_registration" do
    patch :update, id: @u2_f_registration, u2_f_registration: {  }
    assert_redirected_to u2_f_registration_path(assigns(:u2_f_registration))
  end

  test "should destroy u2_f_registration" do
    assert_difference('U2FRegistration.count', -1) do
      delete :destroy, id: @u2_f_registration
    end

    assert_redirected_to u2_f_registrations_path
  end
end
