require 'spec_helper'

describe Camp do

  it "should be factoried" do
    FactoryGirl.create(:camp).should_not be_nil
  end

end
