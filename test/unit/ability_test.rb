require 'test_helper'

describe "Ability without user" do
  before do
    @ab = Ability.new(nil)
  end

  it "read Camp if not closed" do
    camp = create(:camp, closed: false)
    @ab.can?(:read, camp).must_equal true
    camp = create(:camp, closed: true)
    @ab.can?(:read, camp).must_equal false
  end
end

describe "Ability with user" do
  before do
    @user = create(:user)
    @ab = Ability.new(@user)
  end

  it "can add_to UserShelf if collaborator" do
    group = create(:user, group: true)
    group.add_member(@user)
    shelf = create(:user_shelf, group: group)
    @ab.can?(:add_to, shelf).must_equal true
  end

  it "update Camp if owner" do
    camp = create(:camp, user: @user)
    @ab.can?(:update, camp).must_equal true
  end

  it "update Camp if member" do
    group = create(:user, group: true)
    camp = create(:camp, group: group)
    group.add_member(@user)
    @ab.can?(:update, camp).must_equal true
  end
end
