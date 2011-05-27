if !window.console? || !window.console.log?
    window.console = {
        log : -> false
    }

jQuery ->
  $("p.flash").click -> $(this).hide()

