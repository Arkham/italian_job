module ActiveModel
    module Validations
        class CodiceFiscaleFormatValidator < ActiveModel::EachValidator

            def validate_each(object, attribute, value)
                object.errors[attribute] << I18n.translate("activerecord.errors.codice_fiscale.empty") if value.blank?
            end

        end
    end
end
