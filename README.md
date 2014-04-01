A new style forum for tiny community as Rails Engine. You can mount this in you apps.

## Requrements

  * Rails 3.1
  * Mongoid 2.4.x or 3.0.0.rc
  * rails_autolink

## Install

1. In your Gemfile:

    ```ruby
    gem "homeland"
    ```

2. Install through this command:

   ```bash
   rails g homeland:install
   ```

3. Change your application.html.erb

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


4. Add this to your routes.rb:

    ```ruby
    mount Homeland::Engine, :at => "/bbs"
    ```

## Generate views to custom

```bash
rails g homeland:views
```

## How to test Homeland

```bash
$ bundle install
$ cd spec/dummy
$ rails s
INFO  WEBrick 1.3.1
INFO  ruby 1.9.3 (2012-04-20) [x86_64-darwin11.4.0]
INFO  WEBrick::HTTPServer#start: pid=9720 port=3000
```

## Demo App

* [http://720p.so/bbs](http://720p.so/bbs)

----

Thanks [V2EX](http://www.v2ex.com/?r=huacnlee) forum idea.
A new style forum for tiny community as Rails Engine. You can mount this in you apps.
