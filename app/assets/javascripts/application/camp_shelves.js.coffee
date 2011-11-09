
detachSummary = ->
  $('#sidebar_extra').hide()
  container = $('[data-pjax-container]')
  left = "#{container.position().left}px"
  width = "#{container.width()}px"
  height = "#{container.height()}px"
  top = "#{$(window).scrollTop()}px"
  console.log left, top, width, height
  container.remove().appendTo('body').css('position', 'absolute')
  container.css {top: top, left: left, width: width, height: height}

attachSummary = ->
  container = $('[data-pjax-container]')
  container.remove().css('position', 'static')
  $('#sidebar').prepend(container)
  $('#sidebar_extra').show()
  #$("html, body").animate({ scrollTop: 0 }, "slow");

jQuery ->
  $('a[data-pjax]').pjax '[data-pjax-container]',
    timeout: 2000,
    success: ->
      top = $(window).scrollTop()
      if (top > 300)
        detachSummary()
      else
        attachSummary()