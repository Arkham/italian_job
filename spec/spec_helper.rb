$LOAD_PATH << "." unless $LOAD_PATH.include?(".")

require "rubygems"
require "bundler"

Bundler.setup

Bundler.require
require File.expand_path('../../lib/italian_job', __FILE__)

ENV['DB'] ||= 'sqlite3'

database_yml = File.expand_path('../database.yml', __FILE__)
if File.exists?(database_yml)
    active_record_configuration = YAML.load_file(database_yml)[ENV['DB']]

    ActiveRecord::Base.establish_connection(active_record_configuration)
    ActiveRecord::Base.logger = Logger.new(File.join(File.dirname(__FILE__), "debug.log"))

    ActiveRecord::Base.silence do
        ActiveRecord::Migration.verbose = false

        load(File.dirname(__FILE__) + '/schema.rb')
        load(File.dirname(__FILE__) + '/user.rb')
    end  

else
    raise "Please create #{database_yml} first to configure your database. Take a look at: #{database_yml}.sample"
end
