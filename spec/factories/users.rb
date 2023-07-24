FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password { "MyString" }
    roles { [ "User" ] }
    firstname { "MyString" }
    lastname { "MyString" }
    association :current_project, factory: :project
  end
end
