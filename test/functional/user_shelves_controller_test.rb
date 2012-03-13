require 'test_helper'

describe "User shelves controller integration" do
  before do
    create(:camp)
  end

  it "index should show shelves names" do
    create(:user_shelf, name: 'Lista 1')
    create(:user_shelf, name: 'Lista 2')
    visit user_shelves_path
    page.text.must_include 'Lista 1'
    page.text.must_include 'Lista 2'
  end
end
