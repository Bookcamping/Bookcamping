require 'factory_girl'

FactoryGirl.define do
  factory :camp do
    name 'Camp'
    model_name 'book'
  end

  factory :license do
    name 'CreativeCommons'
  end

  factory :user do
    sequence(:name) {|n| "user#{n}" } 
    email { "#{name}@email.com" }
    password { "#{name}-secret"}
    password_confirmation { "#{name}-secret"}
  end

  factory :identity do
    user 
    uid { user.email }
    provider 'bookcamping'
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


  # TODO: refactor DRY
  factory :shelf do
    camp_id 1
    user 
    sequence(:name) {|n| "Shelf #{n}"}
    sequence(:slug) {|n| "Shelf slug #{n}"}
    visibility 'public'
  end

   factory :camp_shelf do
    camp_id 1
    user 
    sequence(:name) {|n| "Camp shelf #{n}"}
    sequence(:slug) {|n| "Camp shelf slug #{n}"}
    visibility 'public'
  end

  factory :user_shelf do
    camp_id 1
    user 
    sequence(:name) {|n| "User shelf #{n}"}
    sequence(:slug) {|n| "User shelf slug #{n}"}
    visibility 'public'
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

  factory :tag do
    sequence(:name) {|n| "Tag#{n}" }
  end

  factory :taggin do
    tag
    association :reference, factory: :book 
    user
  end

  factory :publisher do
    sequence(:name) {|n| "Publisher #{n}"}
  end
end
