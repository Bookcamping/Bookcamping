class Admin::ApplicationController < ApplicationController
  layout 'admin'

  protect_from_forgery
  before_filter :require_admin

  # Disable PaperTrail for /admin
  around_filter do |controller, action|
    PaperTrail.enabled = false
    action.call
    PaperTrail.enabled = true
  end
end


