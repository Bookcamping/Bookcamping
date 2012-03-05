module PublishersHelper
  def publisher_banner(publisher, options = {})
    archive = publisher.archive_slug? ? publisher.archive_slug : 'default'
    options[:src] = "/system/archive/publishers/#{archive}/banner1025x140.jpg"
    options[:width] = '1025'
    options[:height] = '140'
    tag(:img, options)
  end
end
