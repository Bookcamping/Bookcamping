require 'spec_helper'

feature 'view licenses' do
  background do
    FactoryGirl.create(:camp)
    FactoryGirl.create(:license, name: 'License 1')
    FactoryGirl.create(:license, name: 'License 2')
  end

  scenario 'show all licenses' do
    visit licenses_path
    page.should have_content('License 1')
    page.should have_content('License 2')
  end

  scenario 'show a license' do
    license = License.first
    FactoryGirl.create(:book, license: license)
    FactoryGirl.create(:book, license: license)

    visit license_path(License.first)
    page.should have_content 'License 1'
    page.should have_content '2 referencias'
  end

end

    
