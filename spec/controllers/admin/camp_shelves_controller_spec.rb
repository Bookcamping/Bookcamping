require 'spec_helper'

describe Admin::CampShelvesController do
  render_views

  it "should have index" do
    get admin_camps_path
    response.should be_success
  end

end
