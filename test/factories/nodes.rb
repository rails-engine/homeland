FactoryGirl.define do
  factory :node, class: Homeland::Node do
    sequence(:name) { |n| "name#{n}" }
    description 'description'
  end
end
