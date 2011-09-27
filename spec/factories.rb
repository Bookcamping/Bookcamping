require 'factory_girl'

FactoryGirl.define do
  factory :camp do
    name 'Camp'
  end

  factory :license do
    name 'CreativeCommons'
  end

  factory :user do
    name 'User'
  end

  factory :book do
    user
    camp
    license
    title 'Book'
  end

  factory :shelf do
    camp
    user
    name 'Shelf'
  end
end
