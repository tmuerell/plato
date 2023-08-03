FactoryBot.define do
  factory :ticket do
    title { "Ticket" }
    content { "" }
    status { :new }
    association :creator, factory: :user
    association :assignee, factory: :user
    association :project
  end
end
