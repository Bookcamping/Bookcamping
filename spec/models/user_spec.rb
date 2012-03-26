require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  it 'find groups' do
    create(:user, group: false)
    create(:user, group: true)
    User.groups.count.must_equal 1
    User.groups.first.group?.must_equal true
  end

  # OPERATIONS
  it 'should add references' do
    reference = FactoryGirl.create(:reference)
    user.add_reference reference
    user.references.all.should include(reference)
  end

  it 'should add tags' do
    reference = FactoryGirl.create(:reference)
    user.add_tag(reference, 'my tag')
    Tag.count.should == 1
    tag = Tag.first
    tag.name.should == 'My tag'
    reference.taggings.count.should == 1
    reference.taggings.first.tag.should == tag
    reference = FactoryGirl.create(:reference)
    user.add_tag(reference, 'my tag')
    Tag.count.should == 1
    reference.taggings.count.should == 1
    user.taggings.count.should == 2
  end

  # SLUG
  it 'should have slug' do
    user = FactoryGirl.create(:user, name: 'user name')
    user.save
    user.slug.should == 'user-name'
    user.to_param.should == user.slug
    User.find('user-name').should_not be_nil
  end

  # IDENTITIES
  it "should create recovery identity" do
    user = FactoryGirl.create(:user)
    user.recovery_code.should be_nil
    user.generate_recovery_code
    user.recovery_code.should_not be_nil
  end

  it "should create recovery identity" do
    user = FactoryGirl.create(:user)
    user.generate_recovery_code
    user.destroy_recovery_code
    user.recovery_code.should be_nil
  end

  it "should re-create recovery identity" do
    user = FactoryGirl.create(:user)
    user.generate_recovery_code
    code = user.recovery_code
    user.generate_recovery_code
    user.recovery_code.should_not == code
  end

  it "should authorized with password" do
    user = Factory.create(:user, email: 'test@test.com', password: 'secret',
                          password_confirmation: 'secret')
    retrieved = User.authenticate('test@test.com', 'secret')
    retrieved.should_not be_nil
    retrieved.id.should == user.id
  end

  # ROLES
  it "should have super rol" do
    user = Factory.create(:user, rol: 'super')
    user.super?.should == true
    user.admin?.should == true
    user.beta?.should == true
  end

  # AUDIT LOGIN
  it "should audit login" do
    user = Factory.create(:user)
    user.audit_login
    user.login_count.should == 1
    user.last_login_at.should_not be_nil
  end
  # MERGE USERS

end

