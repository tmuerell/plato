require 'rails_helper'

RSpec.describe "user_project_roles/new", type: :view do
  before(:each) do
    assign(:user_project_role, UserProjectRole.new(
      user: nil,
      project: nil,
      role: "MyString"
    ))
  end

  it "renders new user_project_role form" do
    render

    assert_select "form[action=?][method=?]", user_project_roles_path, "post" do

      assert_select "input[name=?]", "user_project_role[user_id]"

      assert_select "input[name=?]", "user_project_role[project_id]"

      assert_select "input[name=?]", "user_project_role[role]"
    end
  end
end
