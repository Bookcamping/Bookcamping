class Admin::CuratedShelvesController < Admin::ShelvesController
  expose(:curated_shelves) { current_camp.curated_shelves }
  expose(:curated_shelf )

  # ALIASES
  expose(:shelves) { curated_shelves }
  expose(:shelf) { curated_shelf }

  def show

  end
end
