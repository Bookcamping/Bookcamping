require 'spec_helper'

describe Color do
  it "should have name and value" do
    color = Color.new
    color.save.should == false
    color.name = 'the name'
    color.save.should == false
    color.value = 'red'
    color.save.should == true
  end
end

