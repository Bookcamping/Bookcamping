
describe Shelf do
  describe "empty shelf" do
    it "should have no references" do
      shelf = FactoryGirl.create(:shelf)
      shelf.references.count.should == 0
      shelf.references_count.should == 0
    end
  end

  it "sould have references" do
    shelf = FactoryGirl.create(:shelf)
    FactoryGirl.create(:reference, include_in_shelf_id: shelf.id)
    shelf.reload
    shelf.references.count.should == 1
    shelf.references_count.should == 1
  end

end