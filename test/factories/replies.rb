FactoryGirl.define do
  factory :topic, class: Homeland::Topic do
    association :topic, factory: :node
    user_id 1
    body 'body'
  end
end
