# encoding: utf-8
require 'spec_helper'

describe Publisher do
  it "should clean slug" do
    p = FactoryGirl.create(:publisher, slug: 'clismón')
    p.slug.should == 'clismon'
  end
end
