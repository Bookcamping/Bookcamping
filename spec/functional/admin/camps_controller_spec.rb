require 'spec_helper'

feature 'manage campings' do
  background do
    FactoryGirl.create(:camp, name: 'Camping 1')
    FactoryGirl.create(:camp, name: 'Camping 2')
    @user = FactoryGirl.create(:user, rol: 'admin')
    visit enter_path(@user.id)
  end

  scenario 'view all camps' do
    visit admin_camps_path
    page.should have_content 'Camping 1'
    page.should have_content 'Camping 2'
  end

  scenario 'show a camp' do
    camp = Camp.first
    visit admin_camp_path(camp)
    page.should have_content camp.name
  end
end

