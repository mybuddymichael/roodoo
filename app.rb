require 'sinatra'
require 'slim'
require 'data_mapper'

Slim::Engine.set_default_options :pretty => true

DataMapper.setup(:default,
              "sqlite://#{File.expand_path(File.dirname(__FILE__))}/db/tdrb.db")

class Task
  include DataMapper::Resource

  property :id,         Serial
  property :body,       Text
  property :created_at, DateTime
  property :tags,       CommaSeparatedList
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
