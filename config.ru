require File.expand_path("../app/api.rb", __FILE__)

file = File.new("./log/rack.log", 'a+')
file.sync = true
use Rack::CommonLogger, file

run Pricing::API
