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

  factory :post do
    camp
    user
    title 'Post Title'
    body 'Post body.'
    author '#bookcamping'
    visibility :public
    published_at Time.now
  end

  factory :media_bites do
    camp
    user
    title 'Media title'
    content_type 'text'
  end
end
