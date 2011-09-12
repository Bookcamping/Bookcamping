class Backend::ApplicationController < ApplicationController
  layout 'backend'

  protect_from_forgery
  before_filter :require_admin
end

