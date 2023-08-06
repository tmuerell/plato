require 'rails_helper'

RSpec.describe "user_project_roles/show", type: :view do
  before(:each) do
    assign(:user_project_role, UserProjectRole.create!(
      user: nil,
      project: nil,
      role: "Role"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Role/)
  end
end
