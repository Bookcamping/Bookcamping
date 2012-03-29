require 'test_helper'

describe 'Camps controller integration' do
  it "show current camp" do
    camp = create(:camp, name: 'Test camp', host: 'host.cc')
    login_with camp.user
    visit gocamp_path(camp)
    visit camp_path(camp)
    page.text.must_include camp.name
    page.text.must_include camp.host
  end

  it "edit and update current camp" do
    camp = create(:camp)
    login_with camp.user
    visit edit_camp_path(camp)
    fill_in 'camp_name', with: 'Nombre'
    fill_in 'camp_host', with: 'bookcamping.cc'
    click_submit
    camp.reload
    page.current_path.must_equal camp_path(camp)
    camp.name.must_equal 'Nombre'
    camp.host.must_equal 'bookcamping.cc'
  end

  it "assign a group to camp" do
    camp = create(:camp)
    group = create(:user, group: true)
    login_with camp.user
    visit edit_camp_path(camp)
    select group.name, from: 'camp_group_id'
    click_submit
    camp.reload
    camp.group.must_equal group
  end
end
