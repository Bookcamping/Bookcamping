# encoding: utf-8
require 'spec_helper'


feature 'View camp shelves' do
  background do
    FactoryGirl.create(:camp)
  end

  scenario 'show all camp shelves' do
    1.upto(4) do |num|
      FactoryGirl.create(:camp_shelf, name: "Estantería #{num}")
    end
    visit camp_shelves_path
    1.upto(4) do |num|
      page.should have_content("Estantería #{num}")
    end
  end

  scenario 'show empty camp shelf' do
    shelf = FactoryGirl.create(:camp_shelf, name: 'Mi estantería')
    visit camp_shelf_path(shelf)
    page.should have_content 'Mi estantería'
  end

end

