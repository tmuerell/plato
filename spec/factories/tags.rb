FactoryBot.define do
  factory :tag do
    name { "Tag" }
    association :project
  end
end
