require 'spec_helper'

describe Tag do
  it "should have slug" do
    tag = Tag.new name: 'my tag'
    tag.save
    tag.slug.should == 'my-tag'
  end

  it "should normalize name" do
    tag = Tag.create name: 'my name'
    tag.save
    tag.name.should == 'My name'
  end

  it "should have counter" do
    tag = Tag.create name: 'my tag'
    tag.size.should == 0
    tag.increment_size
    tag.size.should == 1
  end

  it "should have unique name" do
    tag = Tag.new name: 'my name'
    tag.save.should == true
    tag = Tag.new name: 'My name'
    tag.save.should == false
  end

  it "should have references" do
    user = FactoryGirl.create :user
    user.add_tag(FactoryGirl.create(:reference), 'my tag')
    user.add_tag(FactoryGirl.create(:reference), 'my tag')
    tag = Tag.find_by_name 'My tag'
    tag.references.count.should == 2
  end

  it "should remove taggings on destroy" do
    user = FactoryGirl.create :user
    user.add_tag(FactoryGirl.create(:reference), 'my tag')
    user.add_tag(FactoryGirl.create(:reference), 'my tag')
    tag = Tag.find_by_name 'My tag'
    Tagging.count.should == 2
    tag.destroy
    Tagging.count.should == 0
  end

end
