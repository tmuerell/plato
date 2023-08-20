require 'rails_helper'

RSpec.describe "tag_groups/show", type: :view do
  before(:each) do
    assign(:tag_group, TagGroup.create!(
      name: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
