require 'spec_helper'

describe ShelfMember do
  it "Shelf counter cache should be increased when a ShelfMember is created" do
    user = Factory(:user)
    shelf = Factory(:user_shelf)
    ShelfMember.create!(shelf_id: shelf.id, user_id: user.id)
    shelf.reload
    shelf.shelf_members_count.should == 2
  end
end
