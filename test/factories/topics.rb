FactoryGirl.define do
  factory :topic, class: Homeland::Topic do
    sequence(:title) { |n| "title#{n}" }
    association :user, factory: :user
    association :node, factory: :node
    body 'body'
  end
end
