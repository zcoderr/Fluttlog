---
title: SpringBoot 初探
desc: 测试 Markdown 样式
thumb: http://ppe.oss-cn-shenzhen.aliyuncs.com/collections/91/6/thumb.jpg
location: Beijing
time: 2019-10-26
catalog: 技术日志
tags:['Markdown','Blog']
---

　　Spring的繁琐的配置简直是每个项目开始的时候都会吐槽的地方，特别是对于较为小型的项目，或者是个人项目，过于繁琐的配置就更显得多余了。Spring boot是Spring推出的一个轻量化web框架，主要解决了Spring对于小型项目饱受诟病的配置和开发速度问题。


来自Spring官网对Spring boot的介绍：

```
Takes an opinionated view of building production-ready Spring applications. Spring Boot favors convention over configuration and is designed to get you up and running as quickly as possible.
```

大概意思就是Spring boot是一个简化了配置的Spring，专门为快速开发而设计。

<!--more-->

## 一、入门示例程序

###  1、添加pom依赖

```xml
 <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>1.2.3.RELEASE</version>
    </parent>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <java.version>1.8</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>


    </dependencies>
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>


```

### 2、编写控制器和启动程序
　 1. 控制器和SpringMVC中一样，通过添加注解的方式配置。代码如下：

```java
package control;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
/**
 * Created by zachary on 16/8/8.
 */
@RestController  //声明为控制器
@EnableAutoConfiguration //自动配置
public class Control {
    @RequestMapping("/") //请求路径，和Spring一样
    public String Hello(){
        return "Hello Spring boot!";
    }
    @RequestMapping("/user/{username}") //带参数的请求路径
    public String User(@PathVariable String username){
        return "Hello "+username;
    }
}
```


　 2. 启动程序作为程序入口，包含一个主方法，因为Spring boot 自带容器（默认为tomcat），所以直接运行这个主方法就可以在浏览器中直接访问程序，当然，还需要添加相应注解使上面配置好的控制器可以被自动扫描添加。

**这里有个坑：启动程序必须包含在一个包中，如果直接放在/src/main/java中，自动扫描其它控制器会失效，具体原因等查到了会写上来**

```java
package control;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration //相当于传统的xml配置文
@ComponentScan //表示将该类自动发现（扫描）并注册为Bean，可以自动收集所有的Spring组件，包括@Configuration类。我们经常使用@ComponentScan注解搜索beans，并结合@Autowired注解导入。
@EnableAutoConfiguration

public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

## 二、注解详解

Spring boot 中常用的注解如下：

* @ResponseBody
用该注解修饰的函数，会将结果直接填充到HTTP的响应体中，一般用于构建RESTful的api；

* @Controller
用于定义控制器类，在spring 项目中由控制器负责将用户发来的URL请求转发到对应的服务接口（service层）。

* @RestController
@ResponseBody和@Controller的合集

* @RequestMapping
提供路由信息，负责URL到Controller中的具体函数的映射。

* @EnableAutoConfiguration
Spring Boot自动配置（auto-configuration）：尝试根据你添加的jar依赖自动配置你的Spring应用。例如，如果你的classpath下存在HSQLDB，并且你没有手动配置任何数据库连接beans，那么我们将自动配置一个内存型（in-memory）数据库”。你可以将@EnableAutoConfiguration或者@SpringBootApplication注解添加到一个@Configuration类上来选择自动配置。如果发现应用了你不想要的特定自动配置类，你可以使用@EnableAutoConfiguration注解的排除属性来禁用它们.

* @ComponentScan
表示将该类自动发现（扫描）并注册为Bean，可以自动收集所有的Spring组件，包括@Configuration类。我们经常使用@ComponentScan注解搜索beans，并结合@Autowired注解导入。

* @Configuration
相当于传统的xml配置文件，如果有些第三方库需要用到xml文件，建议仍然通过@Configuration类作为项目的配置主类——可以使用@ImportResource注解加载xml配置文件。

* @SpringBootApplication
相当于@EnableAutoConfiguration、@ComponentScan和@Configuration的合集。

* @Import
用来导入其他配置类。

* @ImportResource
用来加载xml配置文件。

* @Autowired
自动导入依赖的bean

* @Service
一般用于修饰service层的组件

* @Repository
使用@Repository注解可以确保DAO或者repositories提供异常转译，这个注解修饰的DAO或者repositories类会被ComponetScan发现并配置，同时也不需要为它们提供XML配置项。


## 三、部署到tomcat

由此看来，Spring boot确实大大简化了以往的Spring开发，个人认为今后在小型系统中，使用Spring boot毫无疑问。
因为Spring boot自带容器，所以开发完成后将项目部署到tomcat中还需要几步简单的操作：
