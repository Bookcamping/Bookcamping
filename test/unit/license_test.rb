require 'test_helper'

describe License do
  it "must have name" do
    license = create(:license)
    license.name.wont_be :nil?
  end

  it "should create versions" do
    Version.count.must_equal 0
    license = create(:license)
    Version.count.must_equal 1
    license.update_attributes(name: 'Name')
    Version.count.must_equal 2
  end

  it "can have references" do
    license = create(:license)
    create(:reference, license_id: license.id)
    license.references.count.must_equal 1
  end

  it "can't be deleted if have references" do
    license = create(:license)
    license.references << create(:reference)
    license.references.count.must_equal 1
    license.destroy
    license.destroyed?.must_equal false
  end
end
