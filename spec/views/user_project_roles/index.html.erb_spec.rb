require 'rails_helper'

RSpec.describe "user_project_roles/index", type: :view do
  before(:each) do
    assign(:user_project_roles, [
      UserProjectRole.create!(
        user: nil,
        project: nil,
        role: "Role"
      ),
      UserProjectRole.create!(
        user: nil,
        project: nil,
        role: "Role"
      )
    ])
  end

  it "renders a list of user_project_roles" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Role".to_s), count: 2
  end
end
