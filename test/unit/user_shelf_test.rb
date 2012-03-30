require 'test_helper'
require 'unit/shelf_test'

describe UserShelf do
  it "can be found by slug" do
    create(:user_shelf, name: 'My Shelf')
    UserShelf.find('my-shelf').must_be :present?
  end

  it "creates versions" do
    s = create(:user_shelf)
    v = Version.last
    v.item_type.must_equal 'Shelf'
    v.item_id.must_equal s.id
  end
end


