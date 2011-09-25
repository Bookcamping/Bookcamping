# Image explorer module



prepareDraggable = (playground, draggable) ->
  x1 = playground.width() - draggable.width()
  y1 = playground.height() - draggable.height()
  console.log x1, y1
  x2 = 0
  y2 = 0
  $(draggable).css {left: 0, top: 0}
  $(draggable).draggable({containment: [x1, y1, x2, y2]})



# Let explore $(this) using the mouse-drag action of the touch device
$.fn.imageExplore = (options) ->
  @defaultOptions = {viewportId: 'viewport' }
  settings = $.extend({}, this.defaultOptions, options);
  this.each ->
    mapDiv = $(this)

    # Create a fixed viewport to hold the map
    viewport = mapDiv.wrap('<div />').parent().attr('id', settings.viewportId)
    viewport.css({position: 'fixed', overflow: 'hidden', left: 0, top: 0})

    img = $("> img", mapDiv)
    imageDimensions = {width: img.width(), height: img.height()}
    mapDiv.css(imageDimensions)
    if $("html.touch").length # touch device
      viewport.css {position: 'absolute'}
      viewport.css(imageDimensions)
    else # mouse device
      viewport.css({right: 0, bottom: 0})
      prepareDraggable(viewport, mapDiv)


# Implements the RED box
$.fn.linker = (draggable) ->
  this.each ->
    position = null
    linker = $(this)
    linker.text('listo.').css({left: '10px', top: '10px', width: '200px', height: '2em'})
    $(draggable).click (e)->
      if (position == null)
        console.log($(this).css('left'))
        position =
          left: e.pageX - parseInt($(this).css('left'))
          top:  e.pageY - parseInt($(this).css('top'))
        label = "x:#{position.left} / y:#{position.top}"
        linker.text(label)
      else
        position.width = (e.pageX - parseInt($(this).css('left'))) - position.left
        position.height = (e.pageY - parseInt($(this).css('top'))) - position.top;
        label = "left:#{position.left}px;top:#{position.top}px;width:#{position.width}px;height:#{position.height}px;"
        linker.text(label)
        console.log(label)
        $("#linker").css({left: position.left + "px", top: position.top + "px",width: position.width+"px", height:position.height+"px"})
        position = null


$ ->
  $('#map').imageExplore()
  $('#linker').linker('#playground > .draggable')