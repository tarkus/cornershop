require 'test_helper'

class MediaControllerTest < ActionController::TestCase
  setup do
    @medium = media(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:media)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create medium" do
    assert_difference('Medium.count') do
      post :create, medium: { availability: @medium.availability, cast: @medium.cast, description: @medium.description, language: @medium.language, location: @medium.location, producer: @medium.producer, release_year: @medium.release_year, title: @medium.title, type: @medium.type }
    end

    assert_redirected_to medium_path(assigns(:medium))
  end

  test "should show medium" do
    get :show, id: @medium
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @medium
    assert_response :success
  end

  test "should update medium" do
    put :update, id: @medium, medium: { availability: @medium.availability, cast: @medium.cast, description: @medium.description, language: @medium.language, location: @medium.location, producer: @medium.producer, release_year: @medium.release_year, title: @medium.title, type: @medium.type }
    assert_redirected_to medium_path(assigns(:medium))
  end

  test "should destroy medium" do
    assert_difference('Medium.count', -1) do
      delete :destroy, id: @medium
    end

    assert_redirected_to media_path
  end
end
