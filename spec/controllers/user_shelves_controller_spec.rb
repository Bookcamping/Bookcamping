require 'spec_helper'

describe UserShelvesController do
  render_views

  describe 'index' do
    it "should be successful" do
      Factory.create(:camp)
      Factory.create(:user_shelf, name: 'Lista1')
      get 'index'
      response.should be_success
      response.should have_content('Lista1')
    end
  end
end
