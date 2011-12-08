require 'spec_helper'

feature 'read blog posts' do
  scenario 'list latest posts' do
    visit '/blog'
    page.should have_content('Blog')
  end
end
