module ActiveModel
    module Validations
        class CodiceFiscaleValidator < ActiveModel::EachValidator

            def validate_each(object, attribute, value)
                object.errors[attribute] << "Errore" if value.blank?
            end

        end
    end
end
