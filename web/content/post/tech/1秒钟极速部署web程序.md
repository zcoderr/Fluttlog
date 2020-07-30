---
title: 1秒钟，极速部署web程序!
desc: 在开发过程中，修改完代码后部署到服务器是一件头疼的事，每一次部署都要上传代码，重启程序，这个过程最少也需要3分钟的时间，作为程序员，怎么能把时间浪费在这种重复操作上呢，我们可以通过一些现有工具的配合，实现码的自动部署，这篇文章的最终实现效果是将本地中修改完的nodejs代码一键运行在服务器端，其它语言同理，只是使用到的工具会有所不同
thumb: http://ppe.oss-cn-shenzhen.aliyuncs.com/collections/91/8/thumb.jpg
location: Beijing
time: 2017-4-25
catalog: 技术日志
tags:['Markdown','Blog']
---

# 1秒钟，极速部署web程序！

在开发过程中，修改完代码后部署到服务器是一件头疼的事，每一次部署都要上传代码，重启程序，

这个过程最少也需要3分钟的时间，作为程序员，怎么能把时间浪费在这种重复操作上呢，我们可以通过一些现有工具的配合，实现码的自动部署，这篇文章的最终实现效果是将本地中修改完的nodejs代码一键运行在服务器端，其它语言同理，只是使用到的工具会有所不同。**


### 一、准备工作：安装node.js和git

　　我更喜欢用nvm来管理nodejs的版本，nvm需要高版本git支持，而centos yum源里的git版本太低，所以我们要先编译安装新版本的git，关于如何安装，可以看下面这篇文章：

安装新版本git： https://segmentfault.com/a/1190000007134786

##### 1.安装nvm
```shell
yum install curl-devel   #确保curl-devel已经安装
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
#执行完后退出终端重新进入
nvm --version #可以看到nvm版本
```
如果执行curl安装nvm的过程中出现如下错误：fatal: Unable to find remote helper for 'https'，是因为系统找不到git-remote-https，修改下PATH就好了。

<!--more-->

##### 2.修改PATH：
```shell
vi ~/.bash_profile
    PATH=$PATH:/usr/libexec/git-core  #在PATH里添加这一行
source ~/.bash_profile
```
##### 3.使用nvm安装指定版本nodejs
```shell
nvm ls-remote #查看可安装版本
nvm install v6.2.0 #安装一个较为稳定的版本
nvm ls  #查看已经安装的版本
nvm use v4.6.0 #切换版本
nvm alias default v6.2.0 #设置默认版本
node --version  
```

### 二、使用git自动部署代码
接下来我们使用最为优秀的版本控制工具git来同步我在本地和服务器上的代码。

*先梳理一下大致流程：*
* 首先在服务器端创建一个文件夹，使用初始化指令使其成为git的中心仓库。
* 然后在本地电脑新建的项目文件夹中clong上一步在服务器中建立的中心仓库。
* 在服务器中新建一个要部署代码的目录，并clone中心仓库。
* 修改服务器中心仓库中的hook文件，实现本地电脑push代码后，自动部署到上一步建立的代码目录。

*下面是每一步的具体操作：*



##### 1、在服务器中初始化git中心仓库
```shell
mkdir /gitRepo  #新建一个文件夹作为仓库
cd /gitRepo
git init --bare project.git #初始化一个名为progect的仓库
cd project.git #可以看到新仓库中的各个文件
```
　　执行完以上步骤，会在 /gitRepo 文件夹中创建一个名为project的裸库，这个仓库就是之后在客户端的目标仓库


##### 2、在本地电脑克隆远程仓库
要在本地连接到仓库首先需要将本地机器的公钥复制给服务器
```shell
ssh-keygen -t rsa  #如果本地还没有生成公钥和秘钥，使用此命令生成
cat  .ssh/id_rsa.pub #查看生成的公钥，将此公钥复制到服务器的 ~/.ssh/authorized_keys 文件末尾
git clone 用户名@服务器地址:/gitRepo/project.git #在当前目录克隆仓库
```
##### 3、在服务器中配置代码自动部署
```shell
git clong /gitRepo/project.git #在要部署代码的文件夹里克隆仓库
cp post-receive-sample post-receive #拷贝一份示例文件为post-receive
vi post-receive
# 在文件中加入以下指令
    #!/bin/sh
    unset GIT_DIR
    cd 项目路径  #就是进入刚才做克隆操作时的文件夹
    git pull   #执行拉取指令
chmod 775 post-receive  #最后一定要将此文件的权限改为可执行
```
　　执行完所有步骤之后，每次在本地电脑中提交代码到中心仓库，git便会自动将最新的代码pull到服务器中的代码目录。

##### 附：git常用命令
```shell
git add . #添加所有文件到git索引
git commit -m ""  #提交索引到的文件到缓冲区
git push origin master #客户端第一次提交时需要使用此命令提交到远程master分支
git push        #提交缓冲区中的文件
git rm <filename>  #在git索引中移除文件
git rm -r .   #在索引中移除所有文件
```

### 三、node程序自动运行
　　现在通过git提交的代码可以自动部署到服务器的代码目录了，接下来通过使用pm2，在代码变更后让程序自动重启。

```shell
npm install -g pm2  #服务器中全局安装pm2
pm2 start helloworld.js  #使用pm2启动nodejs程序
```

### 四、编写push脚本，一键将本地程序运行在服务器

现在每次使用git提交代码后，服务器会自动部署代码并重启程序，已经不需要我们再对服务器做任何操作了，是不是已经简化了百分之七十的工作量了？但是我们的目标不仅于此，毕竟每次push还需要三条指令呢，作为新时代的程序员，能让电脑做的决不自己去做。所以我们要通过一个脚本，在每次更改完代码之后一键把本地的代码运行在服务器上。

```shell
# 以下为shell脚本，在mac上可以原生执行，使用Windows的同学可以自行搜索bat脚本写法，类推一下。
touch push.sh  #在本地的代码目录新建一个脚本文件。
chmod +x push.sh #设置脚本权限为可执行
vim push.sh  #打开脚本，并写入以下命令
    git add ./
    read commitMessage  
    git commit -m commitMessage  
    git push
    echo Wow！ 代码一键部署完成！

```
** 最后，激动人心的时刻到了，以后每次修改完代码，执行这个命令：`./push.sh`，然后输入提交信息，好了，你的代码已经在服务器上飞起来了！**
