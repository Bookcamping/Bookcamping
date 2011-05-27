search = (term) ->
    url = "/buscar/" + term
    window.location = url

jQuery ->
    $("div.search input[type=text]").change ->
        search $(this).val()

    $("div.search a").click ->
        search $("div.search input[type=text]").val()
        false