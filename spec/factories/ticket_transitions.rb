FactoryBot.define do
  factory :ticket_transition do
    ticket { nil }
    from { "MyString" }
    to { "MyString" }
  end
end
