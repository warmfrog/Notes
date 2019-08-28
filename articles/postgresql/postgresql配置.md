# [postgresql](https://www.postgresql.org/)

Postgres Client 认证是通过 pg_hba.conf 配置文件配置的（HBA 表示 host-based authentication）。通常位于 /etc/postgres/10/pg_hba.conf。

* 重启 postgresql

```bash
sudo /etc/init.d/postgresql restart
```

* 打开 psql 控制台

```bash
sudo -u postgres psql
```

Postgresql 初次安装，默认创建一个 unix 账户 postgres, 可以用来登陆 postgres 数据库，使用 `sudo -u postgres psql` 命令，切换为 postgres 用户运行 psql 程序。

* 创建普通用户

```SQL  
 create role test  password 'test';
```

* 创建管理员用户

```SQL
create role test superuser login password 'test';
```

* 管理员登陆数据库

```bash
psql dbname
```

psql 命令不加参数，默认用户名为 unix 当前登陆用户，数据库默认为当前登陆用户名。

### 创建数据库

```SQL
create database name;
CREATE DATABASE dbname OWNER rolename;
```

```bash
createdb -O rolename dbname
```

### 删除数据库

```SQL
drop database name;
```

```bash
dropdb dbname
```















