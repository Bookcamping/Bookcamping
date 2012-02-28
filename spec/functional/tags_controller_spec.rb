# encoding: utf-8
require 'spec_helper'

feature 'view tags' do
  background do
    FactoryGirl.create(:camp)
  end

  scenario 'list tags' do
    1.upto(4) {|n| FactoryGirl.create(:tag, name: "tag #{n}") }
    visit tags_path
    1.upto(4) {|n| page.should have_content "Tag #{n}" }
  end

  scenario 'list references of tag' do
    user = FactoryGirl.create :user
    ref1 = FactoryGirl.create :reference, title: 'Reference 1'
    ref2 = FactoryGirl.create :reference, title: 'Reference 2'
    user.add_tag ref1, 'My tag'
    user.add_tag ref2, 'My tag'
    tag = Tag.find_by_name 'My tag'
    visit tag_path(tag)
    page.should have_content 'Reference 1'
    page.should have_content 'Reference 2'
  end
    

end

