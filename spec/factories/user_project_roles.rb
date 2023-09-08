FactoryBot.define do
  factory :user_project_role do
    association :user
    association :project
    role { :user }
  end
end
