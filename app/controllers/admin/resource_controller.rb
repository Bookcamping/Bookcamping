class Admin::ResourceController < Admin::ApplicationController
  inherit_resources
  respond_to :html, :json
  has_scope :page, default: 1
  self.responder = Backend::Responder

end

