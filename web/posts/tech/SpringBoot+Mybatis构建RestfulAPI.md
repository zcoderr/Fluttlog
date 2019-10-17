# SpringBoot+Mybatis构建RestfulAPI

### 一、项目结构

<img src="http://o8adsxziw.bkt.clouddn.com/17-3-17/32846690-file_1489738050070_1080c.png" width="400" heigh="500"/>

`pom.xml:`

```xml
 <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>1.5.2.RELEASE</version>
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
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
            <version>1.1.1</version>
        </dependency>
        <!-- mysql 驱动 -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>5.1.38</version>
        </dependency>
        <!-- 数据库连接池 -->
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid</artifactId>
            <version>1.0.5</version>
        </dependency>
        <!-- https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-starter-test -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <version>1.5.2.RELEASE</version>
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

* 启动类Application.java必须放在一个默认包下，所要扫描的组件必须放在其子层包中
* 数据库源配置在application.properties文件中 

`application.properties:`

```xml
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/SpringBoot_01?useUnicode=true&characterEncoding=utf8&allowMultiQueries=true
spring.datasource.username=root
spring.datasource.password=root
```

### 二、注解配置

`Application.java :`

```java
@Configuration //配置类
@EnableAutoConfiguration //根据添加的jar依赖自动配置Spring
@ComponentScan //自动搜索beans，配合@Autowried注解注入
//@SpringBootApplication 注解等价于以默认属性使用 @Configuration , @EnableAutoConfiguration 和 @ComponentScan
public class Application {
    public static void main(String [] args){
        SpringApplication.run(Application.class,args);
    }
}
```

`UserControler.java :`

```java
@RestController //@ResponseBody和@Controller的合集
@ComponentScan //自动搜索beans，配合@Autowried注解注入
@EnableAutoConfiguration
public class UserController {
    @Autowired
    UserServiceImpl userService;
    @RequestMapping("/hello")
    public String Hello(){
        return "hello Spring boot!";
    }
    @RequestMapping("/user/{id}")
    public User getUserById(@PathVariable Integer id){
        return userService.getUserById(id);
    }
    @RequestMapping("/user/del/{id}")
    public int delteUserByid(@PathVariable int id){
        return userService.deletUserByid(id);
    }
}
```

`UserServiceImpl.java : `

```java
@Service  一般用于修饰service层的组件
public class UserServiceImpl implements UserService{
    @Autowired //自动注入
    UserMapper userMapper;

    @Override
    public int addUser(User user) {
        return userMapper.save(user);
    }

    @Override
    public User getUserById(int id) {
        return userMapper.selectById(id);
    }

    @Override
    public int deletUserByid(int id) {
        return userMapper.deleteById(id);
    }
}
```

`UserMapper.java :`

```java
@Mapper //MyBatis注解
public interface UserMapper {

    @Insert("insert into users(name, age) values(#{name}, #{age})")
    int save(User user);

    @Select("select * from user where id=#{id}")
    User selectById(Integer id);

    @Update("update users set ndame = #{name}, age = #{age} where id = #{id}")
    int updateById(User user);

    @Delete("delete from user where id = #{id}")
    int deleteById(Integer id);

    @Select("select *  from user")
    List<User> queryAll();
}
```

### 三、定义数据返回格式

**标准的接口返回体是一个包含返回状态码、状态信息和接口数据的json文本**

* 使用枚举类型定义返回状态码和返回状态信息
* Response类作为返回体的基类
* 继承Response定义不同接口的返回体

###### 1. 使用枚举类型定义返回状态码和返回状态信息

`ResponseCode.java :`

```java
public enum ResponseCode {
        /** 成功 */
        SUCCESS("200", "成功"),

        /** 没有登录 */
        NOT_LOGIN("400", "没有登录"),

        /** 发生异常 */
        EXCEPTION("401", "发生异常"),

        /** 系统错误 */
        SYS_ERROR("402", "系统错误"),

        /** 参数错误 */
        PARAMS_ERROR("403", "参数错误 "),

        /** 不支持或已经废弃 */
        NOT_SUPPORTED("410", "不支持或已经废弃"),

        /** AuthCode错误 */
        INVALID_AUTHCODE("444", "无效的AuthCode"),

        /** 太频繁的调用 */
        TOO_FREQUENT("445", "太频繁的调用"),

        /** 未知的错误 */
        UNKNOWN_ERROR("499", "未知错误");

        private ResponseCode(String code, String msg){
            this.code = code;
            this.msg = msg;
        }

        public String code() {
            return code;
        }

        public String msg() {
            return msg;
        }
        private String code;
        private String msg;
    }
```

###### 2. Response类作为返回体的基类

`Response.java :`

```java
public class Response {
    private String code;
    private String message;
    public Response() {
    }

    public Response(String code , String msg){
        this.code = code;
        this.message = msg;
    }

    public Response(ResponseCode responseCode){
        this.code = responseCode.code();
        this.message = responseCode.msg();
    }

    public String getResponseCode() {
        return this.code;
    }

    public void setResponseCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return this.message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
```

###### 3. 继承Response定义不同接口的返回体

ResponseUserInfo.java :`

```java
public class ResponseUserInfo extends Response {
    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
```

###### 4. 在 Controller 中组装返回体

**在RestControll中根据不同业务组装特定的返回体，接口将直接返回json数据**

```java
@RequestMapping("/user/{id}")
    public ResponseUserInfo getUserById(@PathVariable Integer id){
        ResponseUserInfo responseUserInfo = new ResponseUserInfo();
        responseUserInfo.setResponseCode(ResponseCode.SUCCESS.code());
        responseUserInfo.setMessage(ResponseCode.SUCCESS.msg());
        responseUserInfo.setUser(userService.getUserById(id));
        return responseUserInfo;
    }
```



