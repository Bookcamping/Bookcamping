
module ShelfTest
  def test_that_shelf_always_have_user_and_name
    shelf.user.must_be :present?
    shelf.name.must_be :present?
  end

  def test_that_shelf_create_versions
    shelf
    version = Version.last
    version.must_be :present?
    version.title.must_equal shelf.name
    version.camp_id.must_equal shelf.camp_id
  end

  def test_that_shelf_have_members
    total = shelf.members.count
    shelf.members << create(:user)
    shelf.members.count.must_equal total + 1
  end
end
