require 'test_helper'
require 'unit/shelf_test'

class TestUserShelf < MiniTest::Unit::TestCase
  include ::ShelfTest

  def shelf
    @shelf ||= create(:user_shelf)
  end

  def test_that_name_is_required
    shelf.name.must_be :present?
  end

  def test_that_can_be_found_by_slug
    UserShelf.find(shelf.slug).must_be :present?
  end

  # MEMBERS
  def test_that_owner_membership_is_created
    shelf.members.count.must_equal 1
    shelf.members.first.must_equal shelf.user
  end
end
