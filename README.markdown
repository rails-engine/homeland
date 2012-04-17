A new style forum for small communitys as a Rails Engine. you can mount this in you any apps.

## Install

  * You need install *Ruby 1.9.2*, *Rubygems* and *Rails 3.1* and *Mongoid* first.

1. in you Gemfile:

    gem "homeland"

1. Install thought this commands:    

    rails g homeland:install
    
2. change you application.html.erb

before:
    
    <%= link_to "Home", root_path %>
    <%= link_to "Posts", posts_path %>
    
after:

    <%= link_to "Home", main_app.root_path %>
    <%= link_to "Home", main_app.posts_path %>
    

## Generate views to custom

    rails g homeland:views

Thanks [V2EX](http://v2ex.com) forum idea.
