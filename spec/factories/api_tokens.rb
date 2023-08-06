FactoryBot.define do
  factory :api_token do
    user { nil }
    token { "MyString" }
    description { "MyString" }
  end
end
