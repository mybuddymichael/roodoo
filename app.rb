require 'sinatra'
require 'slim'
require 'data_mapper'

configure do
  Slim::Engine.set_default_options :pretty => true

  pwd = File.expand_path(File.dirname(__FILE__))
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{pwd}/db/tdrb.db")
end

class Task

  include DataMapper::Resource

  property :id,   Serial
  property :body, Text,    required: true
  property :done, Boolean, default:  false

end

DataMapper.auto_migrate!

get '/' do
  slim :index
end

__END__

@@ layout
doctype 5
html
  head
    meta charset='utf-8'
    title = @title
  body
    == yield
