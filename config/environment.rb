require 'bundler/setup'
Bundler.require

configure :development do
  ENV['SINATRA_ENV'] ||= "development"
  Bundler.require(:default, ENV['SINATRA_ENV'])
  ActiveRecord::Base.establish_connection(
    :adapter => "postgresql",
    :database => "clickyz"
  )
end
 
 configure :production do
  encoded_url = URI.encode('postgres://jlfrsqkynlabfq:a23870cc676d6eb0724aef46a7257975e174553e32b964b596252f11eb59b571@ec2-54-161-58-21.compute-1.amazonaws.com:5432/d4162m9d72u9ea')
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
