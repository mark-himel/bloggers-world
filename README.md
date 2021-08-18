# Bloggers World

A blogging application which communicates with an external blog [server](https://github.com/bluethumbart/blog-server).
All blogs will be stored on the server. The application will consume the apis of the server and manipulate the blogs.

What the demo [here](https://recordit.co/kCm0BzSuEK).

## Installation

Install the blog server first:
```
git clone git@github.com:bluethumbart/blog-server.git
cd blog-server
bundle install
shotgun -p 4000
```

* Install the dependencies with `bundle install`
* Copy `.env.example` to `.env`
* Create the database with `rake db:create`
* Simply start the server `rails s -p 3000` and start to play around

## RSpec testing

* Run `rspec` in the terminal to run all spec files
* All spec files are located in the `/spec` directory