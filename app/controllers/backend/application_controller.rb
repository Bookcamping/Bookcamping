class Backend::ApplicationController < ApplicationController
  layout 'backend'

  protect_from_forgery
  before_filter :require_admin

  # Disable PaperTrail for /backend
  around_filter do |controller, action|
    PaperTrail.enabled = false
    action.call
    PaperTrail.enabled = true
  end
end

