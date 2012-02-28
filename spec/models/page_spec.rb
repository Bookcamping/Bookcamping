# encoding: utf-8
require 'spec_helper'

describe Page do
  it "should have slug" do
    page = Factory.create :page, title: 'Una página'
    page.slug.should == 'una-pagina'
    Page.find('una-pagina').should_not be_nil
  end

  it "should generate version" do
    PaperTrail.controller_info = {user_name: 'user_name'}
    page = Factory.create :page, title: 'Página'
    version = Version.last
    version.should_not be_nil
    version.item_type.should == 'Page'
    version.item_id.should == page.id
    version.event.should == 'create'
    #version.camp_id.should == reference.camp_id
    version.title.should == page.title
    version.user_name == 'user_name'

  end
end
