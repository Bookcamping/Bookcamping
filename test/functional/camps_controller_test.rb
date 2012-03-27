require 'test_helper'

describe 'Camps controller integration' do
  it "show current camp" do
    camp = create(:camp, name: 'Test camp', host: 'host.cc')
    visit gocamp_path(camp)
    visit current_camp_path
    page.text.must_include camp.name
    page.text.must_include camp.host
  end

  it "edit and update current camp" do
    camp = create(:camp)
    login_with camp.user
    visit edit_current_camp_path
    fill_in 'camp_name', with: 'Nombre'
    fill_in 'camp_host', with: 'bookcamping.cc'
    click_submit
    page.current_path.must_equal current_camp_path
    camp.reload
    camp.name.must_equal 'Nombre'
    camp.host.must_equal 'bookcamping.cc'
  end

  it "assign a group to camp" do
    camp = create(:camp)
    group = create(:user, group: true)
    login_with camp.user
    visit edit_current_camp_path
    select group.name, from: 'camp_group_id'
    click_submit
    camp.reload
    camp.group.must_equal group
  end
end
