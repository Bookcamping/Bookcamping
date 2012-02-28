require 'spec_helper'

describe Reference do
  it 'should generate version' do
    PaperTrail.controller_info = {user_name: 'my_name'}
    reference = FactoryGirl.create(:reference)
    version = Version.last
    version.item_type.should == 'Reference'
    version.item_id.should == reference.id
    version.event.should == 'create'
    version.camp_id.should == reference.camp_id
    version.title.should == reference.title
    version.user_name == 'my_name'
  end
end
