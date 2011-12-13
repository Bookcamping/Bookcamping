require 'spec_helper'

describe Book do
  it 'should be factoried' do
    FactoryGirl.create(:book).should_not be_nil
  end

  it 'should generate version' do
    book = FactoryGirl.create(:book)
    version = Version.last
    version.item_type.should == 'Book'
    version.item_id.should == book.id
    version.event.should == 'create'
    version.camp_id.should == book.camp_id
    version.title.should == book.title
  end
end
