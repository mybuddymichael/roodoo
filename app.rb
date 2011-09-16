require 'sinatra'
require 'slim'
require 'less'
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
    less:
      // Reset
      html, body, div, span, applet, object, iframe,
      h1, h2, h3, h4, h5, h6, p, blockquote, pre,
      a, abbr, acronym, address, big, cite, code,
      del, dfn, em, img, ins, kbd, q, s, samp,
      small, strike, strong, sub, sup, tt, var,
      b, u, i, center,
      dl, dt, dd, ol, ul, li,
      fieldset, form, label, legend,
      table, caption, tbody, tfoot, thead, tr, th, td,
      article, aside, canvas, details, embed,
      figure, figcaption, footer, header, hgroup,
      menu, nav, output, ruby, section, summary,
      time, mark, audio, video {
        margin: 0;
        padding: 0;
        border: 0;
        font-size: 100%;
        font: inherit;
        vertical-align: baseline;
      }
      /* HTML5 display-role reset for older browsers */
      article, aside, details, figcaption, figure,
      footer, header, hgroup, menu, nav, section {
        display: block;
      }
      body {
        line-height: 1;
      }
      ol, ul {
        list-style: none;
      }
      blockquote, q {
        quotes: none;
      }
      blockquote:before, blockquote:after,
      q:before, q:after {
        content: '';
        content: none;
      }
      table {
        border-collapse: collapse;
        border-spacing: 0;
      }

      // Custom
      body {
        font: 32px Helvetica, Arial, sans-serif;
        width: 480px;
        margin: 32px auto 32px auto;
        color: #333;
      }

      input {
        outline: none;
        border: none;
        background: #ccc;
        font: inherit;
        padding: 2px;
        &:focus { outline: none; }
      }

      h1 {
        font-size: 48px;
      }

      #submit {
        background: transparent;
      }

      #task_input {
        width: 480px;
        height: 40px;
        font-size: 32px;
      }
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
