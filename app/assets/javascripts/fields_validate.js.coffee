validator = new $.SubdomainInputValidator()

validateField = (element) ->
  subdomain = element.value
  $errorsDiv = $(element).parents('.form-group').find('.subdomain-errors')

  validator.subDomain = subdomain

  if validator.isValid()
    $errorsDiv.text('')
  else
    $errorsDiv.text(validator.errors.join(', '))

$ ->
  $subdomainFields = $("[data-subdomain-validation='true']")

  $subdomainFields.each ->
    validateField(@)

  $subdomainFields.on 'input', ->
    validateField(@)