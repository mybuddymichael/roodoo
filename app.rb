require 'sinatra'
require 'slim'
require 'sass'
require 'data_mapper'
require 'pathname'

configure :production do
  require 'dm-postgres-adapter'
end

configure :development do
  require 'dm-sqlite-adapter'
end

configure do
  set :slim, pretty: true

  APP_ROOT = Pathname.new(__FILE__).expand_path.dirname

  DB_DIR = APP_ROOT + 'db'
  DB_DIR.mkpath

  DataMapper.setup(:default,
                   ENV['DATABASE_URL'] || "sqlite://#{DB_DIR}/roodoo.db")
end

class Task

  include DataMapper::Resource

  property :id,   Serial
  property :body, Text,    required: true
  property :done, Boolean, default:  false

end

configure do
  DataMapper.auto_upgrade!
end

get '/' do
  @tasks = Task.all
  slim :main
end

post '/create' do
  Task.create(params[:task])
  redirect('/')
end

get '/delete/:id' do
  Task.get(params[:id]).destroy
  redirect('/')
end

get '*' do
  redirect('/')
end

__END__

@@ layout
doctype 5
html
  head
    meta(charset='utf-8')
    title = @title
    sass:
      body
        font: 20px "Helvetica Neue"
      input
        outline: none
        border: none
        background: #ccc
        font: inherit
        padding: 2px
      input:focus
        outline: none

  body
    == yield

@@ main
h3 New task
form(action='/create' method='post' id='task')
  label(for='body') body:
  input(type='text' name='task[body]' id='body' value='description')

  input(type='submit')

ul
  - @tasks.each do |task|
    li
      = task.body + ' '
      a href="/delete/#{task.id}" delete
