class SubdomainValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    return unless value.present?

    reserved_names = options[:reserved] || %w(www ftp mail pop smtp admin ssl sftp)

    if reserved_names.include?(value)
      object.errors[attribute] << 'cannot be a reserved name'
    end

    object.errors[attribute] << 'must have between 3 and 63 characters' unless (3..63) === value.length
    object.errors[attribute] << 'cannot start or end with a hyphen' unless value =~ /\A[^-].*[^-]\z/i
    object.errors[attribute] << 'must be alphanumeric (or hyphen)' unless value =~ /\A[a-z0-9\-]*\z/i
  end
end