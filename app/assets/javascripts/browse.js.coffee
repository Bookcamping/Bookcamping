jQuery ->
    $("div#browse .book a").live 'click', (e) ->
        $("a.active").removeClass('active')
        $(this).addClass('active')
        previous = $("div#viewer")
        previous.fadeOut ->
            previous.remove()

        $("div#browse").css('right', '400px')
        viewer = $("<div id='viewer'></div>")
        viewer.css('top', e.pageY - 50);
        $(viewer).load this + "/view", ->
            $("body").append(viewer)
            viewer.fadeIn();
        false

    $("#viewer a.back").live 'click', ->
        $("div#viewer").fadeOut ->
            $("a.active").removeClass('active')
            $(this).remove()
            $("div#browse").css('right', '0px')
        false

    $(".download_url a, .description a").live 'click', ->
        window.open($(this).attr('href'),'_blank')
        false

    $("a.open-shelf").click ->
        books = $(this).parents('.shelf').children('.load-shelf')
        if $(this).data('loaded')?
            books.toggle()
        else
            url = $(this).attr('href')
            console.log(this, url)
            books.load(url + ".js")
            $(this).data('loaded', true)
        return false