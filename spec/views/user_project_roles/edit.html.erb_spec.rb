require 'rails_helper'

RSpec.describe "user_project_roles/edit", type: :view do
  let(:user_project_role) {
    UserProjectRole.create!(
      user: nil,
      project: nil,
      role: "MyString"
    )
  }

  before(:each) do
    assign(:user_project_role, user_project_role)
  end

  it "renders the edit user_project_role form" do
    render

    assert_select "form[action=?][method=?]", user_project_role_path(user_project_role), "post" do

      assert_select "input[name=?]", "user_project_role[user_id]"

      assert_select "input[name=?]", "user_project_role[project_id]"

      assert_select "input[name=?]", "user_project_role[role]"
    end
  end
end
