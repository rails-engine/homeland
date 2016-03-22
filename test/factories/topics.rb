FactoryGirl.define do
  factory :topic, class: Homeland::Topic do
    sequence(:title) { |n| "title#{n}" }
    user_id 1
    association :node, factory: :node
    body 'body'
  end
end
