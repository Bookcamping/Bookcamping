require 'spec_helper'
describe UserShelf do
  before :each do
    @camp = FactoryGirl.create(:camp)
    @user = FactoryGirl.create(:user)
    PaperTrail.whodunnit = @user.id
  end

  it "should create versions" do
    puts UserShelf.meta.inspect
    shelf = FactoryGirl.create(:user_shelf)
    puts shelf.inspect
    version = Version.last
    puts version.inspect
    version.item_type.should == 'Shelf'
    version.extra.should == 'UserShelf'
    version.title.should == shelf.name
  end
end

