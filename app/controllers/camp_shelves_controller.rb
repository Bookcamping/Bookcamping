class CampShelvesController < ShelvesController
  expose(:camp_shelves) { current_camp.camp_shelves }
  expose(:camp_shelf)
  # ALIASES
  expose(:shelves) { camp_shelves }
  expose(:shelf) { camp_shelf }
end
