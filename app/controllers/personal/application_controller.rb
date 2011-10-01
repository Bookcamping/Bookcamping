class Personal::ApplicationController < ApplicationController
  before_filter :require_user
end
