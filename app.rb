require 'sinatra'
require 'slim'
require 'data_mapper'

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
  'Hello, world.'
end
