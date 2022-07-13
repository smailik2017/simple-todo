FactoryBot.define do
  factory :task do
    sequence(:description) { |n| "Description#{n}" }
    sequence(:name) { |n| "Name#{n}" }
    user { create(:user) }
    state { create(:state) }
  end
end
