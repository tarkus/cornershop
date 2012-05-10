require 'test_helper'

class LoanHistoriesControllerTest < ActionController::TestCase
  setup do
    @loan_history = loan_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loan_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loan_history" do
    assert_difference('LoanHistory.count') do
      post :create, loan_history: { media_id: @loan_history.media_id, rent_effective: @loan_history.rent_effective, rent_estimated: @loan_history.rent_estimated, rent_start: @loan_history.rent_start, user_id: @loan_history.user_id }
    end

    assert_redirected_to loan_history_path(assigns(:loan_history))
  end

  test "should show loan_history" do
    get :show, id: @loan_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @loan_history
    assert_response :success
  end

  test "should update loan_history" do
    put :update, id: @loan_history, loan_history: { media_id: @loan_history.media_id, rent_effective: @loan_history.rent_effective, rent_estimated: @loan_history.rent_estimated, rent_start: @loan_history.rent_start, user_id: @loan_history.user_id }
    assert_redirected_to loan_history_path(assigns(:loan_history))
  end

  test "should destroy loan_history" do
    assert_difference('LoanHistory.count', -1) do
      delete :destroy, id: @loan_history
    end

    assert_redirected_to loan_histories_path
  end
end
