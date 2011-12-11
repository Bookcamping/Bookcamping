require 'spec_helper'

feature 'read blog posts' do
  background do
    FactoryGirl.create(:camp)
    @post = FactoryGirl.create(:post, title: 'Entrada 1')
  end

  scenario 'list latest posts' do
    visit posts_path
    page.should have_content('Entrada 1')
  end

  scenario 'visit post by slug' do
    visit post_path(@post.slug)
    page.should have_content('Entrada 1')
  end

  scenario 'visit post by id' do 
    visit post_path(@post.id)
    page.should have_content('Entrada 1')
  end

  
end
