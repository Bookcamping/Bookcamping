require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  
  # OPERATIONS
  it 'should add books' do
    book = FactoryGirl.create(:book)
    user.add_book book
    user.my_references_shelf.books.all.should include(book)
  end

  it 'should add tags' do
    book = FactoryGirl.create(:book)
    user.add_tag(book, 'my tag')
    Tag.count.should == 1
    tag = Tag.first
    tag.name.should == 'My tag'
    book.taggings.count.should == 1
    book.taggings.first.tag.should == tag
    book = FactoryGirl.create(:book)
    user.add_tag(book, 'my tag')
    Tag.count.should == 1
    book.taggings.count.should == 1
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

  # PERSONAL SHELVES
  it "should always have personal shelves" do
    user = User.create!(name: 'name', email: 'email@email.com')
    user.like_it_shelf.should_not be_nil
    user.read_later_shelf.should_not be_nil
    user.my_references_shelf.should_not be_nil
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

