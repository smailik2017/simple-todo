FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    password { "111111" }
    role { create(:role) }
  end
end
