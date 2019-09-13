* 查看 maven 运行环境

```bash
mvn --version
```

* 查看构建中 active profiles

```bash
mvn help:active-profiles
```

## Maven 中的包和支持的操作

| 包名 | 描述 |
| -----|------|
| clean | 构建完成后清除 |
| compiler | 编译 Java 源文件 |
| deploy | 部署构建完成的 artifact 到远程仓库 |
| install | 安装构建完成的 artifact 到本地仓库 |
| site | 为当前项目生成一个站点 |
| jar | 为当前项目构建一个jar |
| war | 为当前项目构建一个 war |
| javadoc | 为当前项目生成 javadoc |

## Maven 中特殊的变量

|      |       |
| ---- | ------|
| project.basedir | 当前项目的根目录 |
| project.baseUri | 当前项目根目录，以 Uri 方式展示 | 
| maven.build.timestamp | 构建开始的时间戳 |

