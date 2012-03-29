
describe CampShelf do
  before :each do
    @camp = FactoryGirl.create(:camp)
  end

  it "should create versions" do
    shelf = FactoryGirl.create(:camp_shelf)
    version = Version.last
    version.item_type.should == 'Shelf'
    version.title.should == shelf.name
    version.camp_id.should == shelf.camp_id
  end

  it "should create memberships" do
    shelf = create(:camp_shelf)
    shelf.add_member(create(:user))
    Membership.last.resource_type.must_equal 'CampShelf'
  end

end

