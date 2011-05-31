module AppHelper
  def link_to_list(list)
    case list[:type]
      when 'list'
        link_to t("app.lists.#{list[:name]}").html_safe, '#'
    end
  end
end