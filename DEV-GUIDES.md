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

### 如果有新增 Migration，可以用下面的命令生成到 dummy 文件夹里面

```bash
$ rake homeland:install:migrations
```
