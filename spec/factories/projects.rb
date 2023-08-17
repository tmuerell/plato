FactoryBot.define do
  factory :project do
    name { "Internal" }
    sequence(:shortname) { |n| "INT-#{n}" }
    workflow { { states: { new: { initial: true } } } }
  end
end
