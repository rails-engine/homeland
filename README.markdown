A new style forum for tiny community as Rails Engine. You can mount this in you apps.

## Requrements

  * Rails 3.1
  * Mongoid
  * rails_autolink

## Install

1. in you Gemfile:

    ```ruby
    gem "homeland"
    ```

2. Install thought this commands:    

   ```bash
   rails g homeland:install
   ```
   
3. change you application.html.erb

  before:
    
    ```erb
    <%= link_to "Home", root_path %>
    <%= link_to "Posts", posts_path %>
    ```
    
  after:

    ```erb
    <%= link_to "Home", main_app.root_path %>
    <%= link_to "Home", main_app.posts_path %>
    ```


4. Change you routes.rb to add this:

    ```ruby
    mount Homeland::Engine, :at => "/bbs"
    ```

## Generate views to custom

    ```bash
    rails g homeland:views
    ```
    
## Demo App

* [http://720p.so/bbs](http://720p.so/bbs)

----

Thanks [V2EX](http://www.v2ex.com/?r=huacnlee) forum idea.
