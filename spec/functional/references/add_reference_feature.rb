# encoding: utf-8
require 'spec_helper'

feature 'add reference' do
  background do
    FactoryGirl.create(:camp)
    @user = FactoryGirl.create(:user)
    visit enter_path(@user.id)
  end

  scenario 'add a reference' do
    visit new_reference_path
    puts page.body
    page.should have_content('Dominio público')
  end
end

