# encoding: utf-8
require 'spec_helper'


describe Activities do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @book = FactoryGirl.create(:book, title: 'El libro')
    @version = FactoryGirl.create(:version, whodunnit: @user.id, item: @book, event: 'create')
  end

  it "should validate version" do
    Activities.valid?(@version).should == true
  end

  it "should create activity" do
    activity = Activities.build(@version)
    puts activity.errors.inspect
    activity.new_record?.should == false
    activity.version_id.should == @version.id
    activity.should_not be_nil
    activity.user.should == @user
    activity.resource.should == @book
    activity.action.should == 'create'
    activity.title.should == "añadido la referencia 'El libro'"
  end
end

