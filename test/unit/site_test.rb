require 'test_helper'

describe Site do
  before do
    @site = Site.new
  end

  it "show visible shelves" do
    visible = create(:user_shelf, hidden: false)
    hidden = create(:user_shelf, hidden: true)
    shelves = @site.visible_user_shelves
    shelves.must_include visible
    shelves.wont_include hidden
  end
end
