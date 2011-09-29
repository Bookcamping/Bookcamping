class Admin::ApplicationController < ApplicationController
  layout 'admin'

  protect_from_forgery
  before_filter :require_admin
end
