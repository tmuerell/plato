FactoryBot.define do
  factory :notification_config do
    delivery_type { "" }
    association :project
  end
end
