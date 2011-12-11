class Licenses::LicensesController < ApplicationController
  respond_to :html
  expose_resource :license

  def index
    index!
  end

  def show
    show!
  end

end

