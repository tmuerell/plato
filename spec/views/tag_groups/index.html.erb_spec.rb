require 'rails_helper'

RSpec.describe "tag_groups/index", type: :view do
  before(:each) do
    assign(:tag_groups, [
      TagGroup.create!(
        name: "MyText"
      ),
      TagGroup.create!(
        name: "MyText"
      )
    ])
  end

  it "renders a list of tag_groups" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
