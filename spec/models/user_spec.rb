require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  
  # OPERATIONS
  # 1 ADD BOOK
  it 'should add books' do
    book = FactoryGirl.create(:book)
    user.add_book book
    user.my_references_shelf.books.all.should include(book)
  end

  it 'should add tags' do
    ref1 = FactoryGirl.create(:book)
    ref2 = FactoryGirl.create(:book)
    user.tag ref1, 'To read'
    tg = user.tag ref2, 'to read'
    puts tg.errors.inspect
    Tag.count.should == 1
    Taggin.count.should == 2
    ref1.tags.count.should == 1
    ref2.tags.count.should == 1
    user.tags.count.should == 1
    
  end

  # SLUG
  it 'should have slug' do
    user = FactoryGirl.create(:user, name: 'user name')
    user.save
    user.slug.should == 'user-name'
    user.to_param.should == user.slug
    User.find_by_param('user-name').should_not be_nil
  end

  # IDENTITIES
  it "should destroy recovery identity" do
    user = FactoryGirl.create(:user)
    user.generate_recovery_identity
    user.identities.count.should == 1
    user.destroy_recovery_identity
    user.identities.count.should == 0
  end

  it "should create recovery identity" do
    user = FactoryGirl.create(:user)
    user.identities.count.should == 0
    user.generate_recovery_identity
    user.identities.count.should == 1
    user.identities.first.provider.should == 'recovery'
  end

  it "should re-create recovery identity" do
    user = FactoryGirl.create(:user)
    user.generate_recovery_identity
    user.identities.count.should == 1
    token = user.identities.first.uid
    user.generate_recovery_identity
    user.identities.count.should == 1
    user.identities.first.uid.should_not == token
  end

  it "should identify with password" do
    user = Factory.create(:user)
    user.identify_with('entrar')
    user.identities.count.should == 1
    id = user.identities.first
    id.provider.should == 'bookcamping'
    id.uid == user.email
    id.password_digest.should_not be_nil
    entrar = id.password_digest
    user.identify_with('otro')
    user.identities.first.password_digest.should_not == entrar
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

  # MERGE USERS

end

