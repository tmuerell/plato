FactoryBot.define do
  factory :ticket do
    title { "Ticket" }
    content { "" }
    status { :new }
    priority { :normal }
    association :creator, factory: :user
    association :assignee, factory: :user
    association :project
    association :customer_project
  end
end
