# 如何参与开发 Homeland

```bash
$ bundle install
$ cd test/dummy
$ rake db:create
$ rake db:migrate
$ rake db:seed
$ rails s
```

然后浏览器访问: http://localhost:3000

# 如何允许测试

```
$ rails db:migrate RAILS_ENV=test
$ rake
```


