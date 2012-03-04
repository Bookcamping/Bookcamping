require 'spec_helper'

describe UserShelf do
  before :each do
    @camp = FactoryGirl.create(:camp)
    @user = FactoryGirl.create(:user)
    PaperTrail.whodunnit = @user.id
  end

  it "should have shelf members" do
    shelf = Factory(:user_shelf)
    shelf.reload
    shelf.shelf_members.size.should == 1
    shelf.shelf_members_count.should == 1
  end

  it "should have members" do
    shelf = Factory :user_shelf
    member = Factory(:user)
    shelf.add_member member
    shelf.members.size.should == 2
    shelf.members.should include(shelf.user)
    shelf.members.should include(member)
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

