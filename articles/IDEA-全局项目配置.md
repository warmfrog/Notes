


## 项目默认配置

File->other Settings->Settings for new Projects

### Maven配置

配置conf/settings.xml,添加阿里云仓库

```xml
   <mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>
    </mirror>
```

本地仓库

    <localRepository>E:\mvn_repository</localRepository>