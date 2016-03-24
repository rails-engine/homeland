Homeland
--------

[![Gem Version](https://badge.fury.io/rb/homeland.svg)](https://badge.fury.io/rb/homeland) [![Build Status](https://travis-ci.org/huacnlee/homeland.svg)](https://travis-ci.org/huacnlee/homeland) [![Code Climate](https://codeclimate.com/github/huacnlee/homeland/badges/gpa.svg)](https://codeclimate.com/github/huacnlee/homeland) [![codecov.io](https://codecov.io/github/huacnlee/homeland/coverage.svg?branch=master)](https://codecov.io/github/huacnlee/homeland?branch=master)

> A new style forum for tiny community as Rails Engine. You can mount this in any of you Rails apps.

我们时常可能需要在各类中小型项目中集成用户社区之类的功能，每次当你需要做这个事情的时候都重头设计实现一遍么？ No, that no the Rails way! Rails 教育我们要 DRY!

Homeland 是基于 Rails Engine 实现的论坛社区 Gem，用于快速开发，类似 Devise 给我们解决账号体系的方案一样。它包含数据库、Model、Controller、Views 以及 UI 细节的完整实现，你只需简单几行就能快速在你的现有项目上面集成起来。

## 功能列表

- 分类管理
- 话题发布，管理
- 回帖

## 系统依赖

由于内部包含较多复杂功能，Homeland 不得不需要依赖一些三方库，Homeland 尽可能的选用 Ruby 社区流行的 Gem，保持较小的版本依赖。

建议你使用的时候选择目前 `homeland.gemspec` 里面描述的最佳的三方库版本号。

### 下面是几个基本的

- Rails 4.2.x +
- ActiveRecord 4.2.x +
- Bootstrap 4 Alpha (当然如果你重写 View 可以不管它)

## 安装

仅仅需要几步，就能集成到你的任何应用（当然我说的是 Rails + ActiveRecord 的！）

1. 修改 Gemfile 增加:

```ruby
# Gemfile
gem "homeland"
gem 'font-awesome-sass-rails'
# 如果你用其他 markup 可以不用依赖 github-markup
gem 'github-markup'
```

然后直接 `bundle install` 安装好.

2. 生成 Homeland 的基本配置文件：

```bash
$ rails g homeland:install
```

3. 在 routes.rb 里面 mount Homeland:

```ruby
# config/routes.rb
mount Homeland::Engine, at: "/homeland"
```

4. 自定义配置

```ruby
# config/initializes/homeland.rb
Homeland.configure do
  # self.markup = :markdown
  # self.app_name = 'Homeland'
  # self.per_page = 32
  # self.user_class = 'User'
  # self.user_name_method = 'name'
  # self.user_avatar_url_method = nil
  # self.user_admin_method = 'admin?'
  # self.user_profile_url_method = 'profile_url'
  # self.authenticate_user_method = 'authenticate_user!'
  # self.current_user_method = 'current_user'
end
```

### 如果你有更高级的需要，可以直接生成出 Homeland 的 View 文件，然后按自己的需要定制：

```bash
$ rails g homeland:views
```

你也可以通过下面的命令生成默认的 I18n 文件

```bash
$ rails g homeland:i18n
```

## 实现自己的文章内容格式化

Homeland 默认提供: [:markdown, :simple, :html] 几种可选的内容格式化方式，但某些时候你可能会有更多的需求，需要按自己的需要定制。

Homeland 提供的方式让你达到这个目的。

你需要在 `Homeland::Markup` 命名空间下面实现一个新的自定义类，并继承 `Homeland::Markup::Base`，实现 `render` 函数，例如：

新建文件 lib/homeland/markup/ruby_china.rb

```ruby
module Homeland
  module Markup
    class RubyChina < Base
      class << self
        def render(raw)
          # 在这里编写你的详细转换实现
          YouCustomRender.render(raw)
        end
      end
    end
  end
end
```

需改 config/initializes/homeland.rb

```ruby
Homeland.configure do
  self.markup = :ruby_china
end
```

然后，Homeland 在转换格式的时候，就会用你的自定义 Markup 来处理了。

## Demo App

![2016-03-24 15 27 27](https://cloud.githubusercontent.com/assets/5518/14011062/4ca58542-f1d6-11e5-97bb-e43e67e4686e.png)
![2016-03-24 15 27 45](https://cloud.githubusercontent.com/assets/5518/14011063/4caa8326-f1d6-11e5-9161-ef93afe07465.png)
![2016-03-24 15 27 49](https://cloud.githubusercontent.com/assets/5518/14011061/4ca57bf6-f1d6-11e5-8343-291d7e92bf3c.png)
