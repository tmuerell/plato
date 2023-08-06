FactoryBot.define do
  factory :user_project_role do
    user { nil }
    project { nil }
    role { "MyString" }
  end
end
