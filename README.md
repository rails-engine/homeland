Homeland
--------

A new style forum for tiny community as Rails Engine. You can mount this in you apps.

## Requrements

  * Rails 4.2.x+
  * ActiveRecord
  * Bootstrap 3.2 (Or not if you rewirte views)

## Install

1. In your Gemfile:

    ```ruby
    gem "homeland"
    ```

and then run `bundle install`.

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
    mount Homeland::Engine, at: "/homeland"
    ```

## Generate views for custom by your self.

```bash
rails g homeland:views
```

## Development Homeland

```bash
$ bundle install
$ cd test/dummy
$ rake db:create
$ rake db:migrate
$ rake db:seed
$ rails s
```

And then visit: http://localhost:3000

### Generate Homeland Migration into dummy path

```bash
$ rake homeland:install:migrations
```

## Demo App

![2016-03-22 10 25 48](https://cloud.githubusercontent.com/assets/5518/13940479/ab9d977a-f018-11e5-870e-aa68b9b2ff1f.png)
