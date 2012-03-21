require 'test_helper'

describe 'CampShelvesController integration' do
  it "show all shelves" do
    camp = create(:camp)
    create(:camp_shelf, camp: camp, name: 'Shelf 1')
    visit camp_shelves_path
    page.text.must_include 'Shelf 1'
  end
end
