A new style forum for tiny community as Rails Engine. You can mount this in you apps.

## Install

  * You need install *Ruby 1.9.2*, *Rubygems* and *Rails 3.1* and *Mongoid* first.

1. in you Gemfile:

    gem "homeland"

2. Install thought this commands:    

    rails g homeland:install
    
3. change you application.html.erb

before:
    
    <%= link_to "Home", root_path %>
    <%= link_to "Posts", posts_path %>
    
after:

    <%= link_to "Home", main_app.root_path %>
    <%= link_to "Home", main_app.posts_path %>

4. Change you routes.rb to add this:

    mount Homeland::Engine, :at => "/bbs"
    

## Generate views to custom

    rails g homeland:views

Thanks [V2EX](http://v2ex.com) forum idea.
