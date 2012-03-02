require 'spec_helper'

feature 'View pages: ' do
  background do
    FactoryGirl.create(:camp)
  end

  scenario 'all pages' do
    category = Factory(:category, view_level: :public)
    Category.count.should == 1
    Factory(:page, category: category, title: "Page 1")
    Factory(:page, category: category, title: "Page 2")
    Page.count.should == 2
    visit pages_path
    page.should have_content('Page 1')
    page.should have_content('Page 2')
  end

  scenario 'a page' do
    category = Factory(:category, view_level: :public)
    wiki_page = Factory(:page, category: category, title: 'Page 1')
    visit page_path(wiki_page)
    page.should have_content('Page 1')
  end

end


