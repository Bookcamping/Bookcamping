
describe User do

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

  it "should always have personal shelves" do
    user = User.create!(name: 'name', email: 'email@email.com')
    user.like_it_shelf.should_not be_nil
    user.read_later_shelf.should_not be_nil
    user.my_references_shelf.should_not be_nil
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

end

