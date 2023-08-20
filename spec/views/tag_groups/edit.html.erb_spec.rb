require 'rails_helper'

RSpec.describe "tag_groups/edit", type: :view do
  let(:tag_group) {
    TagGroup.create!(
      name: "MyText"
    )
  }

  before(:each) do
    assign(:tag_group, tag_group)
  end

  it "renders the edit tag_group form" do
    render

    assert_select "form[action=?][method=?]", tag_group_path(tag_group), "post" do

      assert_select "textarea[name=?]", "tag_group[name]"
    end
  end
end
