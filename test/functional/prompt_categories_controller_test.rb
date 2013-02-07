require 'test_helper'

class PromptCategoriesControllerTest < ActionController::TestCase
  setup do
    @prompt_category = prompt_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prompt_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prompt_category" do
    assert_difference('PromptCategory.count') do
      post :create, prompt_category: {  }
    end

    assert_redirected_to prompt_category_path(assigns(:prompt_category))
  end

  test "should show prompt_category" do
    get :show, id: @prompt_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prompt_category
    assert_response :success
  end

  test "should update prompt_category" do
    put :update, id: @prompt_category, prompt_category: {  }
    assert_redirected_to prompt_category_path(assigns(:prompt_category))
  end

  test "should destroy prompt_category" do
    assert_difference('PromptCategory.count', -1) do
      delete :destroy, id: @prompt_category
    end

    assert_redirected_to prompt_categories_path
  end
end
