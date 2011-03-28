module ActiveModel
    module Validations
        class CodiceFiscaleFormatValidator < ActiveModel::EachValidator
            REGEX=Regexp.compile("^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$")

            def validate_each(object, attribute, value)
                if value.blank?
                    object.errors[attribute] << I18n.translate("activerecord.errors.codice_fiscale.empty")
                    return
                end
                unless value.match(REGEX)
                    object.errors[attribute] << I18n.translate("activerecord.errors.codice_fiscale.invalid_format") 
                    return
                end
            end
        end
    end
end
