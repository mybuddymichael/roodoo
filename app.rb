require 'bundler/setup'
Bundler.require(:default)

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

      // Mixins
      .border-radius(@radius: 2px) {
        -webkit-border-radius: @radius;
        -moz-border-radius: @radius;
        border-radius: @radius;
      }

      // Variables
      @base_gray: #ddd;
      @base_blue: #198adb;
      @base_red:  #dc322f;

      // Custom
      body {
        font: 32px 'Helvetica Neue', Helvetica, Arial, sans-serif;
        width: 480px;
        margin: 32px auto 32px auto;
        color: #333;
      }

      a, a:hover, a:active, a:visited {
        color: @base_blue;
      }

      .delete, .delete:hover, .delete:visited {
        color: @base_red;
      }

      .delete:active {
        color: @base_blue;
      }

      input {
        outline: none;
        border: none;
        font: inherit;
        padding: 0;
        &:focus { outline: none; }
      }

      h1 {
        font-size: 48px;
        margin-top: 32px;
        margin-bottom: 8px;
      }

      ul {
        margin-top: 8px;
      }

      #submit {
        background: transparent;
      }

      #task_input {
        width: 480px;
        height: 48px;
        font-size: 32px;
        margin-left: -8px;
        padding-left: 8px;
        padding-right: 8px;
        background: #ddd;
        .border-radius;
        &::-webkit-input-placeholder { color: #888; }
        &:-moz-placeholder { color: #888; }
      }
  body
    == yield

@@ main
h1 roodoo
form(action='/create' method='post' id='task')
  input(type='text' name='task[body]' id='task_input'
        placeholder='A task?' required)

ul
  - @tasks.each do |task|
    li
      = task.body + ' '
      a href="/delete/#{task.id}" delete
