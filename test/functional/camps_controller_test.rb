require 'test_helper'

describe 'Camps controller integration' do
  it "show current camp" do
    camp = create(:camp)
    visit gocamp_path(camp)
    visit current_camp_path
    page.text.must_include camp.name
  end

  it "edit and update current camp" do
    camp = create(:camp)
    login_with camp.user
    visit edit_current_camp_path
    page.current_path.must_equal edit_current_camp_path
    fill_in 'camp_name', with: 'Nombre'
    click_submit
    page.current_path.must_equal current_camp_path
    page.text.must_include 'Nombre'
  end
end
