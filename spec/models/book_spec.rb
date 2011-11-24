
describe Book do
  it 'should be factoried' do
    FactoryGirl.create(:book).should_not be_nil
  end
end
