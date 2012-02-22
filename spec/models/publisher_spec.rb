# encoding: utf-8
require 'spec_helper'

describe Publisher do
  it "should clean slug" do
    Publisher.count.should == 0
    p = Factory.create(:publisher, name: 'clismón')
    p.slug.should == 'clismon'
  end
end
