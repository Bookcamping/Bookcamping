require 'spec_helper'

feature 'view licenses' do
  background do
    FactoryGirl.create(:camp)
  end

  scenario 'show all licenses' do
    Factory.create(:license, name: 'License 1')
    Factory.create(:license, name: 'License 2')
    visit licenses_path
    page.should have_content('License 1')
    page.should have_content('License 2')
  end

  scenario 'show a license' do
    license = Factory.create(:license, name: 'License 1', body: 'Esto es el body')
    FactoryGirl.create(:reference, license: license)
    FactoryGirl.create(:reference, license: license)

    visit license_path(license)
    page.should have_content 'License 1'
    page.should have_content '2 referencias'
    page.should have_content 'Esto es el body'
  end

end

    
