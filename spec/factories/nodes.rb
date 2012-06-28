# coding: utf-8
FactoryGirl.define do
  factory :node, :class => Homeland::Node do
    association :section
    sequence(:name) { |n| "node #{n}" }
    sequence(:summary) { |n| "node summary #{n}" }
  end
end
