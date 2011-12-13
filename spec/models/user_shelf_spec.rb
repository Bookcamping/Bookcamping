require 'spec_helper'

describe UserShelf do
  before :each do
    @camp = FactoryGirl.create(:camp)
    @user = FactoryGirl.create(:user)
    PaperTrail.whodunnit = @user.id
  end

  it "should create versions" do
    shelf = FactoryGirl.create(:user_shelf)
    version = Version.last
    version.item_type.should == 'Shelf'
    version.extra.should == 'UserShelf'
    version.title.should == shelf.name
    version.camp_id.should == shelf.camp_id
  end
end

