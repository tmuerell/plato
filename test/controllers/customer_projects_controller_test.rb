require "test_helper"

class CustomerProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer_project = customer_projects(:one)
  end

  test "should get index" do
    get customer_projects_url
    assert_response :success
  end

  test "should get new" do
    get new_customer_project_url
    assert_response :success
  end

  test "should create customer_project" do
    assert_difference("CustomerProject.count") do
      post customer_projects_url, params: { customer_project: { name: @customer_project.name } }
    end

    assert_redirected_to customer_project_url(CustomerProject.last)
  end

  test "should show customer_project" do
    get customer_project_url(@customer_project)
    assert_response :success
  end

  test "should get edit" do
    get edit_customer_project_url(@customer_project)
    assert_response :success
  end

  test "should update customer_project" do
    patch customer_project_url(@customer_project), params: { customer_project: { name: @customer_project.name } }
    assert_redirected_to customer_project_url(@customer_project)
  end

  test "should destroy customer_project" do
    assert_difference("CustomerProject.count", -1) do
      delete customer_project_url(@customer_project)
    end

    assert_redirected_to customer_projects_url
  end
end
