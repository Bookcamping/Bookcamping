# encoding: utf-8
require 'spec_helper'

feature 'User shelves' do
  background do
    FactoryGirl.create(:camp)
  end

  scenario 'list user shelves' do
    1.upto(4) { |n| FactoryGirl.create(:user_shelf, name: "Lista #{n}") }
    visit user_shelves_path
    1.upto(4) { |n| page.should have_content "Lista #{n}" }
  end

  scenario 'show user shelf' do
    shelf = Factory.create :user_shelf, name: 'Mi lista'
    shelf.add_reference Factory.create(:reference, title: 'Libro')
    visit user_shelf_path(shelf)
    page.should have_content 'Mi lista'
    page.should have_content 'Libro'
  end
end
