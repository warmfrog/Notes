# PostGresql

* 查看数据库列表

```SQL
\l
```

* 切换数据库

```SQL
\c dbname
```

* 查看数据库下的所有 schema

```SQL
select * from information_schema.schemata;

* 查看表

```SQL
\d table_name
```

* 插入数据

```SQL
INSERT INTO weather VALUES ('San Francisco', 46, 50, 0.25, '1994-11-27');
```

* 查询表

```SQL
SELECT * FROM weather;
```

* 删除表

```SQL
DROP TABLE my_first_table;
DROP TABLE products;
```

* 创建表

```SQL
CREATE TABLE products (
    product_no integer NOT NULL,
    name text NOT NULL,
    price numeric NOT NULL CHECK (price > 0)
);
```

```SQL
CREATE TABLE products (
    product_no integer UNIQUE,
    name text,
    price numeric
);
```

```SQL
CREATE TABLE products (
    product_no integer PRIMARY KEY,
    name text,
    price numeric
);
```

## 修改表

* 添加列

```SQL
ALTER TABLE products ADD COLUMN description text;
ALTER TABLE products ADD COLUMN description text CHECK (description <> '');
```

* 删除列

```SQL
ALTER TABLE products DROP COLUMN description;
```

* 增加约束

```SQL
ALTER TABLE products ADD CHECK (name <> '');
ALTER TABLE products ADD CONSTRAINT some_name UNIQUE (product_no);
ALTER TABLE products ADD FOREIGN KEY (product_group_id) REFERENCES product_groups;
```









