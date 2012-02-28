require 'spec_helper'

describe UserShelf do
  before :each do
    @camp = FactoryGirl.create(:camp)
    @user = FactoryGirl.create(:user)
    PaperTrail.whodunnit = @user.id
  end

  it "should create versions" do
    shelf = Factory.build :user_shelf
    shelf.save.should == true
    version = Version.last
    version.should_not be_nil
    version.item_type.should == 'Shelf'
    #version.extra.should == 'UserShelf'
    version.title.should == shelf.name
    version.camp_id.should == shelf.camp_id
  end
end

