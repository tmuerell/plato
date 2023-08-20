require 'rails_helper'

RSpec.describe "tag_groups/new", type: :view do
  before(:each) do
    assign(:tag_group, TagGroup.new(
      name: "MyText"
    ))
  end

  it "renders new tag_group form" do
    render

    assert_select "form[action=?][method=?]", tag_groups_path, "post" do

      assert_select "textarea[name=?]", "tag_group[name]"
    end
  end
end
