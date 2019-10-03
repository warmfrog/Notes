# booksp

`show tables;`

```text
+------------------+
| Tables_in_booksp |
+------------------+
| access_log       |
| article          |
| book             |
| roles            |
| software         |
| type             |
| user_role        |
| users            |
+------------------+
8 rows in set (0.08 sec)

mysql>
```

`desc article;`

```text
+---------------+--------------+------+-----+-------------------+----------------+
| Field         | Type         | Null | Key | Default           | Extra          |
+---------------+--------------+------+-----+-------------------+----------------+
| id            | int(11)      | NO   | PRI | NULL              | auto_increment |
| title         | varchar(200) | NO   |     | ""                |                |
| type_id       | int(11)      | YES  |     | NULL              |                |
| author_id     | int(11)      | NO   |     | NULL              |                |
| intro         | varchar(100) | YES  |     | ""                |                |
| url           | varchar(200) | NO   |     | ""                |                |
| date          | datetime     | NO   |     | CURRENT_TIMESTAMP |                |
| img_url       | varchar(200) | YES  |     |                   |                |
| thumbnail_url | varchar(200) | YES  |     | NULL              |                |
+---------------+--------------+------+-----+-------------------+----------------+
9 rows in set (0.17 sec)
```

```sql
select title from article where title like 'linux%';
select id from type where name like 'linux';
update article set type_id = (select id from type where name like 'linux') where title like 'linux%';
```

![sql](/img/query-two-table.png)
