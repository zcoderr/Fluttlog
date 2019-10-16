---
title: 用 Gradle 构建基于 Kotlin 的 Spring boot 项目
image: https://picsum.photos/1080/720?grayscale
publish: 2018-04-15
type: post
categories:
  - tech
readingTime: Beijing
---

## 用 Gradle 构建基于 Kotlin 的 Spring boot 项目

#### 一、配置本地Gradle

1. 官网下载Gradle压缩包
2. 解压到/usr/local/bin目录
3. 添加gradle的环境变量



#### 二、新建项目

1. 选择从 Spring Initializr 创建
2. 填写项目必要信息，选择 Type 为 Gradle Project，选择 Packaging 方式和 Kotlin 语言，next
3. 选择 Spring boot 版本和要包含的模块(web,jpa,mybatis等)，next
4. 填写项目名称，Finish
5. 选择 Use local gradle distribution 并填写正确的 Gradle home 路径，ok



#### 三、配置 build.gradle

​	进入项目后，更改工程 build.gradle 文件中的仓库以加快 gradle 依赖的加载速度。国内仓库：

 `maven{ url 'http://maven.aliyun.com/nexus/content/groups/public/'}`



#### 四、部署配置

​	如果打包方式选择为 war 包，则需要为项目配置运行容器，以 Tomcat 为例：

1. 选择 Edit Configurations 标签，点击加号选择 Tomcat Server 添加一项配置
2. 在 Server 标签中选择本地存在的 Tomcat 路径，设置容器 Name
3. 选择 Deployment 标签，点击加号选择 Artifacts，选择一个要部署的 war 包，ok
4. 在配置文件`application.properties`中填写必要的配置信息
5. 现在项目已经可以运行

