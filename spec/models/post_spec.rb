require 'spec_helper'

describe Post do
  it "should mark as 'draft' when not 'published'" do
    post = FactoryGirl.create(:post, visibility: 'published')
    post.visibility.should == 'published'
    post = FactoryGirl.create(:post, visibility: :published)
    post.visibility.should == 'published'
    post = FactoryGirl.create(:post, visibility: 'algo')
    post.visibility.should == 'draft'
  end

  it "should retrieve all published posts" do
    FactoryGirl.create(:post, visibility: 'published')
    FactoryGirl.create(:post, visibility: 'published')
    FactoryGirl.create(:post, visibility: 'draft')
    Post.published.size.should == 2
  end

  it "should have uniqueness title" do
    FactoryGirl.create(:post, title: 'A title')
    p = FactoryGirl.build(:post, title: 'A title')
    p.save.should == false
  end

  it "should have slug" do
    p = FactoryGirl.create(:post, title: 'Post title')
    p.slug.should == 'post-title'
  end
end
