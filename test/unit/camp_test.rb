require 'test_helper' 

describe Camp do
  it "must have name" do
    camp = create(:camp)
    camp.name.must_be :present?
  end
end
