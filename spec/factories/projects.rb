FactoryBot.define do
  factory :project do
    name { "Internal" }
    sequence(:shortname) { |n| "INT-#{n}" }
  end
end
