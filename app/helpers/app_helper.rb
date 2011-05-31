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
end