
callback = (data) ->
    $("#" + data.book_id + "-" + data.name).text(data.count).parent().addClass('notice')
    notice = $("<div class='notice'>#{data.message}</div>")
    $("#messages").append(notice)
    window.setTimeout (-> notice.remove()), 2000

jQuery ->
    $('a.like_it').live 'click', ->
        $.post $(this).attr('href') + '.json', {mark: 'like_it'}, callback
        $(this).fadeOut();
        false

    $('a.read_later').live 'click', ->
        $.post $(this).attr('href') + '.json', {mark: 'read_later'}, callback
        $(this).fadeOut();
        false
