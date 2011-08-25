require 'sinatra'
require 'slim'
require 'data_mapper'
require 'dm-postgres-adapter'

configure :development do
  require 'dm-sqlite-adapter'
end

configure do
  Slim::Engine.set_default_options :pretty => true

  pwd = File.expand_path(File.dirname(__FILE__))
  DataMapper.setup(:default,
                   ENV['DATABASE_URL'] || "sqlite://#{pwd}/db/tdrb.db")
end

class Task

  include DataMapper::Resource

  property :id,   Serial
  property :body, Text,    required: true
  property :done, Boolean, default:  false

end

configure :development do
  DataMapper.auto_migrate!
end

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

@@ index
p Hello.
