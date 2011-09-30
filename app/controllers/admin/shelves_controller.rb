class Admin::ShelvesController < Admin::ApplicationController
  expose(:shelves) { current_camp.shelves }
  expose(:shelf) { current_camp.shelves }

  def index

  end
end