FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "Content#{n}" }
    user { User.all.sample }
    commentable { Task.all.sample }
    parent { Comment.all.sample }
  end
end
