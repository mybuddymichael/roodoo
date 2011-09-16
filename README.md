roodoo
======

**Roodoo** is a free to-do list app, built using [Ruby] and [Sinatra], designed
to be run with a free [Heroku] account, for easy access anywhere and on any
device.

## Benefits

Compared to a native solution like Things or Omnifocus, **roodoo** has several
advantages:

- It's **free as in beer**. Roodoo can be run using a _free_ [Heroku] instance.
- It's **free as in speech**. Fork it, optimize it, laugh at it.
- You can **access it anywhere**. Roodoo is a web-app, meaning you can read and
  edit your to-dos anywhere you have internet access.

## Installation

    $ git clone git://github.com/mybuddymichael/roodoo.git
    $ cd roodoo
    $ bundle install --without production
    $ bundle exec foreman start web

Then go to http://localhost:5000/ and try it out.

**Roodoo** can also be run with [Pow] by simply linking it into your `~/.pow`
directory, like so:

    $ cd ~/.pow
    $ ln -s ~/Path/to/roodoo

Then simply visit http://roodoo.dev/.

(Automatic remote installation isn't finished yet, but if you're familiar with
[Heroku], you can figure it out.)

## License

The MIT License

Copyright © 2011 Michael Hanson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


[Ruby]: http://www.ruby-lang.org/en/
[Sinatra]: http://www.sinatrarb.com/
[Heroku]: http://www.heroku.com/
[Pow]: http://pow.cx/
