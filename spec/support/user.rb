class User < ActiveRecord::Base

    attr_accessible :codice_fiscale,:partita_iva,:email

    validates :codice_fiscale, :codice_fiscale_format=>true

end
