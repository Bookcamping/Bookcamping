

prepareDraggable = (playground, draggable) ->
  x1 = playground.width() - draggable.width()
  y1 = playground.height() - draggable.height()
  console.log x1, y1
  x2 = 0
  y2 = 0
  $(draggable).css {left: 0, top: 0}
  $(draggable).draggable({containment: [x1, y1, x2, y2]})

$.fn.mapper = (options) ->
  @defaultOptions = {draggableSelector: '.draggable' }
  settings = $.extend({}, this.defaultOptions, options);
  this.each ->
    playground = $(this)
    draggable = $("> #{settings.draggableSelector}", playground)
    img = $("> img", draggable)
    draggable.css {width: img.width(), height: img.height()}
    prepareDraggable(playground, draggable)


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
  $('#playground').mapper()
  $('#linker').linker('#playground > .draggable')