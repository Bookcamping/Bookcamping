require 'spec_helper'

describe RefTag do
  it "should have slugs" do
    tag = RefTag.new(name: 'Mi tag')
    tag.save.should == true
    tag.slug.should == 'mi-tag'
  end
end
