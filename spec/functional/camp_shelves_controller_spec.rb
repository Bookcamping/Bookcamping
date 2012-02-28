# encoding: utf-8
require 'spec_helper'

feature 'Camp shelves' do
  background do
    FactoryGirl.create(:camp)
  end

  scenario 'list' do
    1.upto(4) {|n| FactoryGirl.create(:camp_shelf, name: "Estantería #{n}") }
    visit camp_shelves_path
    1.upto(4) {|n| page.should have_content "Estantería #{n}" }
  end

  scenario 'show' do
    shelf = Factory.create :camp_shelf, name: 'Estantería'
    1.upto(4) {|n| Factory.create(:reference, title: "Libro #{n}", include_in_shelf_id: shelf.id) }
    visit camp_shelf_path(shelf)
    page.should have_content 'Estantería'
    1.upto(4) {|n| page.should have_content "Libro #{n}" }
  end

  scenario 'show select reference' do
    visit enter_path(Factory.create(:user).id)
    shelf = Factory.create :camp_shelf, name: 'Estantería'
    visit select_camp_shelf_references_path(shelf)
    page.should have_field 'title'
  end

  scenario 'show selectable references' do
    visit enter_path(Factory.create(:user).id)
    shelf = Factory.create :camp_shelf, name: 'Estantería'
    Factory.create :reference, title: 'Libro'
    visit select_camp_shelf_references_path(shelf)
    page.fill_in 'title', with: 'libr'
    page.click_button 'submit-search'
    page.should have_content 'Libro'
  end

end

