
describe User do

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

