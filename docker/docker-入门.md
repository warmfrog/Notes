# Docker 入门

* [Docker 仓库,镜像地址][0]
* [Docker 菜鸟教程][1]

## Docker 安装

```bash
wget -qO- https://get.docker.com/ | sh
```

## docker 命令

* 启动 Docker 服务

当以非 root 用户使用 docker 时可能报错，具体原因及解决办法参考[以非root用户身份管理Docker][3]。

`sudo service docker start`

* 查看 Docker 服务状态

`sudo service docker status`

* 查看本地主机镜像

```bash
docker images
```

* 搜索网络镜像

`docker search (httpd)`

* 拉取镜像

```bash
docker pull httpd
```

* 运行使用镜像

`docker run httpd`

* 查看 Docker 当前运行的容器

`docker ps`

* 查看 Docker 容器内标准输出

`docker logs 2b17a2394`
`docker logs amazing_cori`

* 停止 Docker 容器

`docker stop 2b1b7a489832`
`docker stop amaxing_cori`

[安装参考菜鸟教程][2]

[0]: https://hub.docker.com
[1]: https://runoob.com/docker
[2]: https://www.runoob.com/docker/ubuntu-docker-install.html
