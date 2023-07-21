require "application_system_test_case"

class CustomerProjectsTest < ApplicationSystemTestCase
  setup do
    @customer_project = customer_projects(:one)
  end

  test "visiting the index" do
    visit customer_projects_url
    assert_selector "h1", text: "Customer projects"
  end

  test "should create customer project" do
    visit customer_projects_url
    click_on "New customer project"

    fill_in "Name", with: @customer_project.name
    click_on "Create Customer project"

    assert_text "Customer project was successfully created"
    click_on "Back"
  end

  test "should update Customer project" do
    visit customer_project_url(@customer_project)
    click_on "Edit this customer project", match: :first

    fill_in "Name", with: @customer_project.name
    click_on "Update Customer project"

    assert_text "Customer project was successfully updated"
    click_on "Back"
  end

  test "should destroy Customer project" do
    visit customer_project_url(@customer_project)
    click_on "Destroy this customer project", match: :first

    assert_text "Customer project was successfully destroyed"
  end
end
