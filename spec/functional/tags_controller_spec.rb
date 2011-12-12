# encoding: utf-8
require 'spec_helper'

feature 'view tags' do
  background do
    FactoryGirl.create(:camp)
  end

  scenario 'list tags' do
    visit tags_path
  end
end

