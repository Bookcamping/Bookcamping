
describe Camp do
  describe "relations" do
    it "should have medias" do
      camp = FactoryGirl.create(:camp)
      FactoryGirl.create(:media_bite, camp: camp)
      FactoryGirl.create(:media_bite, camp: camp)
      camp.media_bites.count.should == 2
    end
  end
end
