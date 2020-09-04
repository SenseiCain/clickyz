require 'bundler/setup'
require 'dotenv/load'
Bundler.require

Dotenv.load

configure :development do
  ENV['SINATRA_ENV'] ||= "development"
  Bundler.require(:default, ENV['SINATRA_ENV'])
  ActiveRecord::Base.establish_connection(
    :adapter => "postgresql",
    :database => "clickyz"
  )
end
 
 configure :production do
  encoded_url = URI.encode('postgres://wwsalxzfieypup:314499cc62165c8b82cc6f51b31aea34da2127a10e1a495735b0f451d6e4b248@ec2-54-86-170-8.compute-1.amazonaws.com:5432/dc72pdva0nbjj6')
  db = URI.parse(encoded_url)
 
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
 end

require './app/controllers/application_controller'
require_all 'app'
