require 'spec_helper'

feature 'read blog posts' do
  background do
    FactoryGirl.create(:camp)
    FactoryGirl.create(:post, title: 'Entrada 1')
  end

  scenario 'list latest posts' do
    visit posts_path
    page.should have_content('Entrada 1')
  end
end
