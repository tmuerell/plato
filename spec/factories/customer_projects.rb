FactoryBot.define do
  factory :customer_project do
    name { "My customer project" }
    association :project
  end
end
