

currentNotice = -1
notices = null

loadNotices = ->
  $.getJSON '/notices.json', (response) ->
    notices = response
    showNextNotice()

showNextNotice = ->
    currentNotice++
    currentNotice = 0 if currentNotice == notices.length
    notice = notices[currentNotice]
    html = "<p class='#{notice.level}'>#{notice.body}</p>"
    $('#notices').hide().html(html).fadeIn()
    setTimeout noticeTransition, 20000 if notices.length > 1

noticeTransition = ->
    $('#notices').fadeOut(showNextNotice)



jQuery ->
  setTimeout loadNotices, 1000

