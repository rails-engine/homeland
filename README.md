Homeland
--------

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


### 如果你有更高级的需要，可以直接生成出 Homeland 的 View 文件，然后按自己的需要定制：

```bash
$ rails g homeland:views
```

## Demo App

![2016-03-22 10 25 48](https://cloud.githubusercontent.com/assets/5518/13940479/ab9d977a-f018-11e5-870e-aa68b9b2ff1f.png)
