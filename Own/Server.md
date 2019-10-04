# 阿里云服务器

## 物理配置

> * 地址： 47.106.116.17
> * 配置： 1 vCPU, 2GiB内存, 1Mbps带宽, 40GB存储
> * 操作系统： Ubuntu 18.04.1 LTS


## 用户/组管理

1. 用户
>root 超级管理员
postgres Postgresql 数据库用户
>warmfrog sudo 用户，docker

1. 组

> * docker
> * root


## 环境配置

1. Docker

docker 19.03.2

2. Postgresql

>安装位置：/usr/share/postgresql/10/
数据目录：/var/lib/postgresql/10/main
配置目录：/etc/postgresql/10/main/pg_hba.conf,postgresql.conf
>日志目录：

重新加载配置文件
```bash
pg_ctl reload
```

角色

 notes

配置从任何地址访问 ip:0.0.0.0/0


