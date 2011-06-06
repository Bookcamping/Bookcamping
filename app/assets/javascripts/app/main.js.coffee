current_main = null
current_viewer = null

WAIT = '<p>&nbsp;<span class="iconic spinner"></span>Un momento...</p>'

load_main = (url) ->
    console.log 'main', url
    if current_main != url
        current_main = url
        $("#app .main").html(WAIT).load(url)
        true
    else
        false

load_viewer = (url) ->
    console.log 'viewer', url
    if current_viewer != url
        current_viewer = url
        $("#app .viewer").html(WAIT).load(url)

clean_viewer = ->
    current_viewer = null
    $("#app .viewer").html('')

jQuery ->

    $(window).hashchange ->
        current = location.hash
        console.log 'hash', current
        if current.match /^\/?#?$/
            location.hash = '#/lista/ultimas'
        else if match = /^#\/seccion\/(\w+)$/.exec(current)
            clean_viewer() if load_main('/seccion/' + match[1])
        else if match = /^#\/lista\/(\w+)$/.exec(current)
            clean_viewer() if load_main('/lista/' + match[1])
        else if match = /^#\/lista\/(\w+)\/ver\/(\d+)\s*$/.exec(current)
            load_main('/lista/' + match[1])
            load_viewer('/referencia/' + match[2] + "/view")
        else if match = /^#\/listas\/(\d+)$/.exec(current)
            clean_viewer() if load_main('/listas/' + match[1] + "/grid")
        else if match = /^#\/listas\/(\d+)\/ver\/(\d+)\s*$/.exec(current)
            load_main('/listas/' + match[1] + "/grid")
            load_viewer('/referencia/' + match[2] + '/view')
        else
            console.log("unknown location", location.hash)
            location.hash = '#/lista/ultimas'

        $("#app .browser a.active").removeClass('active')
        if current.match /(\/ver\/.*)/
            current = current[0..-((RegExp.$1).length + 1)]
        $("a[href='#{current}']").addClass('active');

    $(window).hashchange()

    $("#app .browser a").live 'click', ->
        hash = $(this).data('hash')
        if hash?
            location.hash = hash
            false
        else
            true

    $("#app .main .book .content a").live 'click', ->
        url = $(this).attr('href')[12..-1]
        current = location.hash
        if current.match /(\/ver\/.*)/
            current = current[0..-((RegExp.$1).length + 1)]
        location.hash = current + '/ver/' + url
        false

