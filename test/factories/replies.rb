FactoryGirl.define do
  factory :reply, class: Homeland::Topic do
    association :topic, factory: :node
    user_id 1
    body 'body'
  end
end
