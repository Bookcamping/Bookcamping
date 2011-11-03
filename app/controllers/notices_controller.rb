class NoticesController < ApplicationController
  respond_to :json

  def index
    @notices = Notice.all
    respond_with @notices
  end
end

