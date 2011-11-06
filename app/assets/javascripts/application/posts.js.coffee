
checkLicense = ->
  license = $(this).val()
  if license is '1' or license is '9'
    $('#reference_url').hide()
  else
    $('#reference_url').show()


jQuery ->
  $('#book_license_id').change(checkLicense)
  $('#book_license_id').each(checkLicense)
