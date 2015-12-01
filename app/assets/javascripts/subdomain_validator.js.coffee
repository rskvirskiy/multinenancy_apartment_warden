class SubdomainInputValidator
  constructor: (@subDomain) ->

  isValid: () ->
    @errors = []

    if @._reservedSubdomains.indexOf(@subDomain) > -1
      @errors.push 'cannot be a reserved name'

    if @subDomain.length < 3 || @subDomain.length > 63
      @errors.push 'must have between 3 and 63 characters'

    unless /^[^-].*[^-]$/i.test(@subDomain)
      @errors.push 'cannot start or end with a hyphen'

    unless /^[a-z0-9\-]*$/i.test(@subDomain)
      @errors.push 'must be alphanumeric (or hyphen)'

    return @errors.length == 0

  _reservedSubdomains: ['www', 'ftp', 'mail', 'pop', 'smtp', 'admin', 'ssl', 'sftp']

$.SubdomainInputValidator = SubdomainInputValidator