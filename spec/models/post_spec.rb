require 'spec_helper'

describe Post do
  it "should retrieve all public posts" do
    FactoryGirl.create(:post, visibility: 'public')
    FactoryGirl.create(:post, visibility: 'public')
    FactoryGirl.create(:post, visibility: 'draft')
    Post.public.size.should == 2
  end
end
