require "italian_job/validators"

if Rails::VERSION::MAJOR >= 3
  #puts "CIAO"
  ## include InstanceMethods to expose the ExistenceValidator class to ActiveModel::Validations
  #ActiveModel::Validations.__send__(:include, ItalianJob::Validators::InstanceMethods)
  #
  ## extend the ClassMethods to expose the validates_presence_of method as a class level method of ActiveModel::Validations
  #ActiveModel::Validations.__send__(:extend, ItalianJob::Validators::ClassMethods)
else
  require "rails2/validator"
  ActiveRecord::Base.__send__(:extend, ItalianJob::Validators)
end