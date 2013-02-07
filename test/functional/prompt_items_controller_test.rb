require 'test_helper'

class PromptItemsControllerTest < ActionController::TestCase
  setup do
    @prompt_item = prompt_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prompt_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prompt_item" do
    assert_difference('PromptItem.count') do
      post :create, prompt_item: {  }
    end

    assert_redirected_to prompt_item_path(assigns(:prompt_item))
  end

  test "should show prompt_item" do
    get :show, id: @prompt_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prompt_item
    assert_response :success
  end

  test "should update prompt_item" do
    put :update, id: @prompt_item, prompt_item: {  }
    assert_redirected_to prompt_item_path(assigns(:prompt_item))
  end

  test "should destroy prompt_item" do
    assert_difference('PromptItem.count', -1) do
      delete :destroy, id: @prompt_item
    end

    assert_redirected_to prompt_items_path
  end
end
