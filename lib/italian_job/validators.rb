require "active_model"

module ItalianJob
  module Validators

    class ItalianTaxCodeValidator < ActiveModel::EachValidator
      REGEX=Regexp.compile("^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$")
      DISPARI=[1, 0, 5, 7, 9, 13, 15, 17, 19, 21, 1, 0, 5, 7, 9, 13, 15, 17, 19, 21, 2, 4, 18, 20, 11, 3, 6, 8, 12, 14, 16, 10, 22, 25, 24, 23]

      def validate_each(object, attribute, value)
        return if value.blank?
        if !value.match(REGEX) || !control_code_valid?(value)
          object.errors[attribute] << I18n.translate("activerecord.errors.codice_fiscale.invalid_format")
        end
      end

      private
      def control_code_valid?(value)
        odds, evens = [], []
        value[0..14].split('').each_with_index {|e,i| (i+1).odd? ? odds << e : evens << e}
        odd = odds.inject(0) { |sum, current_char| sum + DISPARI[(current_char.ord < 65 ? current_char.to_i : ((current_char.ord - 54)-1))] }
        even = evens.inject(0) { |sum, current_char| sum + (current_char.ord < 65 ? current_char.to_i : current_char.ord - 65) }
        ( ((odd + even) % 26) + 65).chr == value[15].chr
      end
    end

    class ItalianVatCodeValidator < ActiveModel::EachValidator
      REGEX=Regexp.compile("^[0-9]{11}$")
      def validate_each(object, attribute, value)
        return if value.blank?
        if !value.match(REGEX) || !control_code_valid?(value)
          object.errors[attribute] << I18n.translate("activerecord.errors.partita_iva.invalid_format")
        end
      end

      private
      def control_code_valid?(value)
        odds, evens = [], []
        value[0..9].split('').map(&:to_i).each_with_index {|e,i| (i+1).odd? ? odds << e : evens << e}
        x = odds.inject(0) { |sum,d| sum + d }
        y = 2 * ( evens.inject(0) { |sum,d| sum + d } )
        z = evens.select { |d| d >= 5 }.size
        t = ( x + y + z ) % 10
        value[10].chr.to_i == (10 - t) % 10
      end
    end

  end
end

module ActiveModel::Validations::HelperMethods
  def validates_italian_tax_code_format_of(*attr_names)
    validates_with ItalianJob::Validators::ItalianTaxCodeValidator, _merge_attributes(attr_names)
  end
  def validates_italian_vat_format_of(*attr_names)
    validates_with ItalianJob::Validators::ItalianVatCodeValidator, _merge_attributes(attr_names)
  end
end
