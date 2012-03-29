require 'test_helper' 

describe User do
  it "find groups" do
    create(:user, group: true)
    create(:user, group: false)
    User.groups.count.must_equal 1
    User.groups.first.must_be :group?
  end

  it "has user groups" do
    user = create(:user)
    g1 = create(:user, group: true)
    g1.add_member(user)
    g2 = create(:user, group: true)
    g2.add_member(user)
    groups = user.user_groups
    groups.size.must_equal 2
    groups.must_include g1
    groups.must_include g2
  end
end
