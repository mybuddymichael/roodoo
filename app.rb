require 'sinatra'
require 'slim'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'pathname'

configure :development do
  require 'dm-sqlite-adapter'
end

configure do
  set :slim, pretty: true

  APP_ROOT = Pathname.new(__FILE__).expand_path.dirname
  DataMapper.setup(:default,
                   ENV['DATABASE_URL'] || "sqlite://#{APP_ROOT}/db/tdrb.db")
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
