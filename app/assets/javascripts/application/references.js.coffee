
puts = (text) -> console.log(text)

class ReferenceSelector

  constructor: ->
    @button = $('a.select-references')
    @container = $('div.books.container')
    @main = $('div#selection')
    @main.find('.messages div').live 'click', -> $(this).remove()
    @controls = $('div.selection-controls').hide()
    @controls.find('button').click(@addToShelf)
    @controls.find('#shelf_name').autocomplete
      source: $('#shelf_name').data('autocomplete-source')
    @controls.find('.cancel').click @disableSelection
    @label = $('.select-text')
    @selecting = false
    @selected = []
    @button.click @enableSelection


  enableSelection: =>
    @selected = []
    @controls.show()
    @controls.find('button').attr('disabled', true)
    @label.text('0 referencias')
    @container.find('.book').addClass('unselected')
    @container.find('.book a').bind 'click', @addToSelection
    @container.find('.book').bind 'click', @addToSelection
    @button.hide()
    @selecting = true
    false

  disableSelection: =>
    @controls.hide()
    @selected = null
    @label.text('')
    @container.find('.book').removeClass('unselected')
    @container.find('.book a').unbind 'click', @addToSelection
    @container.find('.book').unbind 'click', @addToSelection
    @button.show()
    @selecting = false
    false

  addToSelection: (event) =>
    @controls.find('button').attr('disabled', false)
    item = $(event.currentTarget).closest('.book')
    item.removeClass('unselected')
    @selected.push(item)
    @label.text "#{@selected.length} referencias"
    false

  addToShelf: (event) =>
    name = $.trim @controls.find('#shelf_name').val()
    if name.length > 0
      ids = (@referenceIdOf ref for ref in @selected).join(',')
      url = @controls.find('button').data('url')
      console.log 'POST DATA', url, ids
      @disableSelection()
      @message('working', 'Guardando...')
      $.ajax type: 'POST', url: url, dataType: 'json', data: {shelf_name: name, reference_ids: ids}, success: (response) =>
        message = "¡Guardado! La lista <a href='#{response.url}'>#{response.name}</a> tiene #{response.count} referencias."
        @message('success', message)
    else
      @controls.find('#shelf_name').focus()

  message: (type, text) ->
    @main.find('.messages').html("<div class='#{type}'>#{text}</div>")




  referenceIdOf: (ref) =>
    $(ref).attr('id').match(/(\d+)/)[1]









jQuery ->
  new ReferenceSelector
