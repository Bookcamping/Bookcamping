class ShelfItemsController < ApplicationController
  autocomplete :book, :title, :full => true
end
