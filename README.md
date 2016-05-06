Homeland
--------

[![Gem Version](https://badge.fury.io/rb/homeland.svg)](https://badge.fury.io/rb/homeland) [![Build Status](https://travis-ci.org/rails-engine/homeland.svg)](https://travis-ci.org/rails-engine/homeland) [![codecov.io](https://codecov.io/github/rails-engine/homeland/coverage.svg?branch=master)](https://codecov.io/github/rails-engine/homeland?branch=master) [![](http://inch-ci.org/github/rails-engine/homeland.svg?branch=master)](http://inch-ci.org/github/rails-engine/homeland?branch=master)

> A new style forum for tiny community as Rails Engine. You can mount this in any of you Rails apps.

演示网站: https://homeland-app.herokuapp.com

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

仅仅需要几步，就能集成到你的任何应用（当然我说的是 Rails + ActiveRecord 的！）。

> [提示]: Homeland 的默认配置是增对 Devise 设计的，你可以从配置文件里面看到，很多参数都是 Devise 的默认值。所以我建议大家尽可能的使用 Devise 来配合（如果情况允许的话），否则你需要实现一些必要的参数，详见后面的配置文件说明。

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

3. 自定义配置

```ruby
# config/initializes/homeland.rb
# Homeland Config
Homeland.configure do
  # 正文格式化方式, [:markdown, :plain, :html], 默认: :markdown
  # self.markup = :markdown

  # 应用名称
  # self.app_name = 'Homeland'

  # 分页每页条数
  # self.per_page = 32

  # 重要！用户 Model 的 Model 名称, 默认: 'User'
  # self.user_class = 'User'

  # 在 User model 里面表示用户姓名、昵称的函数名称。
  # 用于 Homeland 页面显示发帖回帖人名称, 默认: 'name'
  # 例如:
  # class User
  #   def name
  #     self.email.split('@').first
  #   end
  # end
  # self.user_name_method = 'name'

  # 在 User model 里面，用户头像 URL 的函数名称，默认: nil
  # 当这个参数 nil 的时候，我们会用一个默认头像在页面上显示
  # 关于尺寸，请给至少 64x64 以上
  # self.user_avatar_url_method = nil

  # 在 User model 里面，检测用户是否有 Homeland 管理权限的函数，默认: 'admin?'
  # 此函数目的是为了告诉 Homeland，此用户是否可以管理论坛的回帖发帖，请返回 true, false
  # self.user_admin_method = 'admin?'

  # 在 User model 里面提供用户个人页面 URL（用于页面上点击用户名、头像的目标页面）
  # 默认: 'profile_url'
  # self.user_profile_url_method = 'profile_url'

  # 在 Controller 里面，检查限制必须登录的函数（参见 Devise 的 authenticate_user! 方法）
  # 默认: 'authenticate_user!'
  # 此方法要求检查用户是否登录，未登录跳转到登录页面
  # self.authenticate_user_method = 'authenticate_user!'

  # 在 Controller 里面，获取当前用户对象的函数（参加 Devise 的 current_user 方法)
  # 默认: 'current_user'
  # 要求这个函数返回一个 User 对象
  # self.current_user_method = 'current_user'
end

```

### 如果你有更高级的需要，可以直接生成出 Homeland 的 Model, Controller, View 文件，然后按自己的需要定制：

```bash
$ rails g homeland:models
$ rails g homeland:controllers
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
