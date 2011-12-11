require 'factory_girl'

FactoryGirl.define do
  factory :camp do
    name 'Camp'
  end

  factory :license do
    name 'CreativeCommons'
  end

  factory :user do
    sequence(:name) {|n| "user#{n}" } 
    email { "#{name}@email.com" }
  end

  factory :book do
    user
    camp_id 1
    license
    title 'Book'
  end

  factory :version do
    event 'create'
    whodunnit '1'
    title 'title'
    user_name 'user'
    processed false
  end
    

  factory :shelf do
    camp_id 1
    user
    name 'Shelf'
    visibility 'public'

    factory :camp_shelf, :parent => :shelf do
      type 'CampShelf'
    end
    factory :user_shelf, :parent => :shelf do
      type 'UserShelf'
    end
    factory :curated_shelf, :parent => :shelf do
      type 'CuratedShelf'
    end
  end

  factory :post do
    user
    sequence(:title) {|n| "Post #{n}" } 
    body 'Post body.'
    author '#bookcamping'
    visibility :published
    published_at Time.now
  end

  factory :media_bite do
    camp
    user
    title 'Media title'
    content_type 'text'
  end
end
