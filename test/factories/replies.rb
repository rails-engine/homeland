FactoryGirl.define do
  factory :reply, class: Homeland::Reply do
    association :topic, factory: :topic
    user_id 1
    body 'body'
  end
end
