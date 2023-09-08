FactoryBot.define do
  factory :tag_group do
    name { "MyText" }
    association :project
  end
end
