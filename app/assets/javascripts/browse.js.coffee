jQuery ->

    # click on a book
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

    $("a#show_all_books").click ->
        $(".load-shelf").slideDown();
        self = $(this)
        unless self.data('loaded')?
            self.data('loaded', true)
            $.getScript($(this).attr('href') + ".js")
        false

    $("a#hide_all_books").click ->
        $(".load-shelf").slideUp()

    $("#viewer a.back").live 'click', ->
        $("div#viewer").fadeOut ->
            $("a.active").removeClass('active')
            $(this).remove()
            $("div#browse").css('right', '0px')
        false

    $(".download_url a, .description a").live 'click', ->
        window.open($(this).attr('href'),'_blank')
        false

    # open a shelf
    $("a.open-shelf").click ->
        books = $(this).parents('.shelf').children('.load-shelf')
        if books.data('loaded')?
            books.slideToggle()
        else
            books.show()
            url = $(this).attr('href')
            books.load(url + ".js")
            books.data('loaded', true)
        return false