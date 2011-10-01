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
    visibility 'public'

    factory :camp_shelf, :parent => :shelf do
    end
    factory :user_shelf, :parent => :shelf do
    end
    factory :curated_shelf, :parent => :shelf do
    end
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

  factory :media_bite do
    camp
    user
    title 'Media title'
    content_type 'text'
  end
end
