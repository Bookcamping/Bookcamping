module AppHelper
  def link_to_list(list)
    case list[:type]
      when 'list'
        link_to t("app.lists.#{list[:name]}").html_safe, "#/lista/#{list[:name]}", :class => 'list'
      when 'shelf'
        link_to list[:name], "#/listas/#{list[:id]}", :class => 'shelf'
    end
  end
end