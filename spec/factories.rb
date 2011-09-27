require 'factory_girl'

FactoryGirl.define do
  factory :camp do
    name 'camp'
  end

  factory :license do
    name 'creative_commons'
  end

  factory :user do
    name 'user'
  end


  factory :book do
    user
    camp
    license
    title 'book'
  end
end
