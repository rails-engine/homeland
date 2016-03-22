FactoryGirl.define do
  factory :node do
    sequence(:name) { |n| "name#{n}" }
    description 'description'
  end
end
