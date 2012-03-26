require 'test_helper'

describe 'Licenses integration' do
  before do
    create(:camp)
  end

  it "index should list titles" do
    create(:license, name: 'License 1')
    create(:license, name: 'License 2')
    visit licenses_path
    page.text.must_include 'License 1'
    page.text.must_include 'License 2'
  end

  it "show should give license info" do
    license = create(:license)
    visit license_path(license)
    page.text.must_include license.name
  end

  it "new should be admin only" do
    login_with(nil)
    visit new_license_path
    page.current_path.wont_equal new_license_path
    login_with (create(:user))
    visit new_license_path
    page.current_path.wont_equal new_license_path
    login_with(create(:user, rol: 'admin'))
    visit new_license_path
    page.current_path.must_equal new_license_path
  end

  it "new should create license" do
    login_with(create(:user, rol: 'admin'))
    visit new_license_path
    fill_in 'license_name', with: 'License name'
    fill_in 'license_body', with: 'License body'
    click_submit
    License.count.must_equal 1
    page.text.must_include 'License name'
    page.text.must_include 'License body'
  end

  it "edit can't be anonymous" do
    license = create(:license)
    login_with(nil)
    visit edit_license_path(license)
    page.current_path.wont_equal edit_license_path(license)
  end

  it "edit should update license" do
    license = create(:license)
    login_with(create(:user))
    visit edit_license_path(license)
#   page.has_selector?('#license_name').must_be false
    fill_in 'license_body', with: 'The body'
    click_submit
    page.current_path.must_equal license_path(license)
    page.text.must_include 'The body'
  end
end
