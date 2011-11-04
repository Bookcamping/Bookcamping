require 'spec_helper'

describe Admin::CampShelvesController do
  integrate_views

  it "should have index" do
    get '/admin/campamentos' #admin_camps_path
    response.should be_success
  end

end
