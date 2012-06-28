# coding: utf-8
FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user-#{n}" }
    sequence(:email) { |n| "user#{n}@gmail.com" }
    password "123123"
  end
end
