search = (term) ->
    if term.length < 3
        $("#search-error").text('Pon tres letras al menos, no?')
    else
        url = "/buscar/" + term
        window.location = url

jQuery ->
    $("div.search form").submit (e) ->
      e.preventDefault()
      e.stopPropagation()
      search $(this).val()
      false

    $("div.search input[type=text]").change (e) ->
        e.preventDefault()
        e.stopPropagation()
        search $(this).val()
        false

    $("div.search a").click ->
        search $("div.search input[type=text]").val()
        false

