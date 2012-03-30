require 'test_helper'
require 'unit/shelf_test'

describe UserShelf do
  it "can be found by slug" do
    create(:user_shelf, name: 'My Shelf')
    UserShelf.find('my-shelf').must_be :present?
  end
end


