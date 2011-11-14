
jQuery ->
  $('select.color-select').each ->
    selector = $(this)
    value = $('<span class="color-value">color</span>')
    value.insertAfter(selector)

    updateColor = ->
      color = selector.val()
      value.text(selector.find('option:selected').text())
      value.css('background-color', color)

    selector.change updateColor
    updateColor()

