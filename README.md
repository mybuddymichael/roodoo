roodoo
======

**Roodoo** is a web-based to-do list app, built using [Ruby] and
[Sinatra], designed to be run with a free [Heroku] account.

## Installation

    $ git clone git://github.com/mybuddymichael/roodoo.git
    $ cd roodoo
    $ bundle install --without production
    $ bundle exec foreman start web

Then go to http://localhost:5000/ and try it out.

**Roodoo** can also be run with [Pow] by simply linking it into your
`~/.pow` directory, like so:

    $ cd ~/.pow
    $ ln -s ~/Path/to/roodoo

Then simply visit http://roodoo.dev/.

(Automatic remote installation isn't finished, but if you're familiar
with [Heroku], you can figure it out.)


[Ruby]: http://www.ruby-lang.org/en/
[Sinatra]: http://www.sinatrarb.com/
[Heroku]: http://www.heroku.com/
[Pow]: http://pow.cx/
