# coding: utf-8
FactoryGirl.define do
  factory :section, :class => Homeland::Section do
    sequence(:name) { |n| "section #{n}" }
  end
end
