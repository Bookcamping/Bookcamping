require 'spec_helper'

describe Book do
  it 'should generate version' do
    PaperTrail.controller_info = {user_name: 'my_name'}
    book = FactoryGirl.create(:book)
    version = Version.last
    version.item_type.should == 'Book'
    version.item_id.should == book.id
    version.event.should == 'create'
    version.camp_id.should == book.camp_id
    version.title.should == book.title
    version.user_name == 'my_name'
  end
end
