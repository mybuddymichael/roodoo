require 'sinatra'
require 'slim'
require 'data_mapper'

DataMapper.setup(:default,
              "sqlite://#{File.expand_path(File.dirname(__FILE__))}/db/tdrb.db")

get '/' do
  'Hello, world.'
end
