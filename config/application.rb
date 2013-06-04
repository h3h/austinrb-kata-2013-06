require 'em-synchrony/activerecord'
require 'yaml'

db = YAML.load(File.open('config/database.yml'))[Goliath.env.to_s]
puts "Establishing db connection: #{db.inspect}"
ActiveRecord::Base.establish_connection(db)
