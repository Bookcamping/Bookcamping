class Backend::ResourceController < Backend::ApplicationController
  layout 'backend'

  inherit_resources
  respond_to :html
  has_scope :page, default: 1
  self.responder = Backend::Responder
end

