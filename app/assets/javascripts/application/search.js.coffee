search = (term) ->
    if term.length < 3
        $("#search-error").text('Pon tres letras al menos, no?')
    else
        url = "/buscar/" + term
        window.location = url

jQuery ->
    $("div#search input[type=text]").change ->
        search $(this).val()

    $("div#search a").click ->
        search $("div.search input[type=text]").val()
        false

    $("div.search-results").highlight($("#search-term").text());