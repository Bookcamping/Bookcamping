require 'spec_helper'

feature 'show users' do
  background do
    FactoryGirl.create(:camp)
  end

  scenario 'show all users' do
    1.upto(4) do |num|
      FactoryGirl.create(:user, name: "Usuario #{num}")
    end

    visit users_path
    1.upto(4) do |num|
      page.should have_content "Usuario #{num}"
    end
  end
end

