module AppHelper
  def link_to_list(list)
    case list[:type]
      when 'list'
        link_to t("app.lists.#{list[:name]}").html_safe,
                list_path(list[:name]), :data => {:hash => "#/lista/#{list[:name]}"}, :class => 'list'
      when 'shelf'
        link_to list[:name], shelf_path(list[:id]),
                :data => {:hash => "#/listas/#{list[:id]}"}, :class => 'shelf'
    end
  end

  def browse_book_path(shelf, book)
    browse_shelf_path(shelf) + "/ver/#{book.id}"
  end

  def browse_shelf_path(shelf)
    app_path + "#/listas/#{shelf.id}"
  end

end