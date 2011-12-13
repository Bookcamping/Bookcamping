require 'spec_helper'

describe Identity do
  it "should find by credentials" do
    id = FactoryGirl.create(:identity)
    id.provider = 'bookcamping'
    id.password = 'secret'
    id.uid = 'me@email.com'
    id.save!
    Identity.identify_credentials('me@email.com', 'secret').should == id
  end

  it "should authorize" do
    id = FactoryGirl.create(:identity, provider: 'bookcamping')
    id.password = 'secret'
    id.authorized?('something').should == false
    id.authorized?('secret').should == true
  end

end
