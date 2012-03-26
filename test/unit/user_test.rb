require 'test_helper' 

describe User do
  it "find groups" do
    create(:user, group: true)
    create(:user, group: false)
    User.groups.count.must_equal 1
    User.groups.first.must_be :group?
  end
end
