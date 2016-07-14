### README

去年成功面试的一个海外的公司给的题目，两小时内做完，主要是做一个内容发布系统，内容修改可以记录版本。

我一共做了两版，一版的历史记录是在数据库(分支master)、另一版的历史记录使用Git(分支git)

#####主要功能

* 新建文章

* 新建分类

* 文章分类

* 文章历史版本管理

* 可恢复文章到任一历史版本

#####How To Run

`git clone https://github.com/kesin/HappyValley.git`

`bundle install`

`rake db:migrate`

`rails s`

访问地址: https://localhost:3000/
