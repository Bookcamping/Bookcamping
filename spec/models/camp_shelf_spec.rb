
describe CampShelf do
  before :each do
    @camp = FactoryGirl.create(:camp)
  end

  it "should create versions" do
    shelf = FactoryGirl.create(:camp_shelf)
    shelf.class.should be(CampShelf)
    version = Version.last
    version.item_type.should == 'CampShelf'
  end
end

