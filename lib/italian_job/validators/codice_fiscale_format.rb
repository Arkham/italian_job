module ActiveModel
    module Validations
        class CodiceFiscaleFormatValidator < ActiveModel::EachValidator
            REGEX=Regexp.compile("^[A-Za-z]{6}[0-9]{2}[A-Za-z][0-9]{2}[A-Za-z][0-9]{3}[A-Za-z]$")

            def validate_each(object, attribute, value)
                if value.blank?
                    object.errors[attribute] << I18n.translate("activerecord.errors.codice_fiscale.empty")
                    return
                end
                if value != value.upcase
                end
                unless value.match(REGEX)
                    bject.errors[attribute] << I18n.translate("activerecord.errors.codice_fiscale.invalid_format") 
                    return
                end
            end
        end
    end
end
