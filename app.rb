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

  DB_DIR = APP_ROOT + 'db'
  DB_DIR.mkpath

  DataMapper.setup(:default,
                   ENV['DATABASE_URL'] || "sqlite://#{DB_DIR}/tdrb.db")
end

class Task

  include DataMapper::Resource

  property :id,   Serial
  property :body, Text,    required: true
  property :done, Boolean, default:  false

end

configure :development do
  DataMapper.auto_upgrade!
end

get '/' do
  slim :index
end

get '/new' do
  slim :new
end

post '/create' do
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
