
基本库级操作
    SELECT DATABASE();  ==>显示当前数据库名称, 如果没有执行USE db_name, 显示 NULL
    SHOW {DATABASE | SCHEMA} LIKE expr;     ==>显示当前用户有权看到的所有数据库
    SHOW CREATE {DATABASE | SCHEMA} db_name;
    USE database_name;  ==>切换到指定数据库
    创建指定数据库
        CREATE {DATABASE | SCHEMA} [IF NOT EXISTS] database_name [DEFAULT] CHARACTER
        SET [=] charset_name | [DEFAULT] COLLATE [=] collate_name;
    删除数据库
        DROP {DATABASE | SCHEMA} [IF EXISTS] db_name
    显示数据库中的所有表
        SHOW TABLES {FROM | IN} db_name [LIKE 'pattern' WHERE expr]
        >SHOW TABLES;
    删除表
        DROP TABLE [IF EXISTS] {tb_name | tb_name list};


表级操作
    重命名表
        ALTER TABLE played RENAME TO playlist;
        RENAME TABLE tb_name TO new_tb;
    显示表的结构
        SHOW COLUMNS FROM tb_name;
        DESC tb_name;
        e.g.    SHOW COLUMNS FROM artist; DESC artist;

简单查询语句 SELECT
    SELECT * FROM artist;   SELECT artist_name FROM artist WHERE artist_id=3;

    条件语句 WHERE:
        比较运算符: =, >, <, <>/!=
        逻辑运算符: AND/&&, OR/||, NOT/~, XOR <==(没有符号表示)
        正则表达式: LIKE "L%", LIKE 'L_%';

    排序语句 ORDER BY:
        - 排序列可以是多个，每个列可以有自己的排序方式 DESC|ASC，列之间必须 ',' 隔开
        SELECT * FROM artist ORDER BY artist_name, artist_id DESC | ASC
        SELECT time, track_name FROM track WHERE time < 3.6 ORER BY time DESC, track_name ASC;
        - 可以对列按二进制编码排序，BINARY
        SELECT track_name FROM track WHERE track_name < 'b';
        SELECT track_name FROM track WHERE track_name < BINARY 'b';
        - 可以使用 CAST 和 AS 对列先进行数据类型转换，然后按照新类型排序
        SELECT time, track_name FROM track ORDER BY time;
        SELECT time, track_name FROM track ORDER BY CAST(time AS CHAR);

        转换类型: AS {BINARY | SIGNED | UNSIGNED | CHAR | DATE | DATETIME | TIME}

    行数限制语句 LIMIT:
        - 单一数字n: 只去 n 条记录，从头取
        SELECT track_name from track LIMIT 5;
        - 双数字 n, m, 中间必须有逗号，从第 n+1 开始，取 m 条记录
        SELECT track_name FROM track LIMIT 3, 5;   ==>3 to 7 (该表记录从 0 开始)
        - 双数字 limit n OFFSET m, 不能有逗号出现，通过 OFFSET 指定跳过的记录数, 格式固定
        SELECT track_name FROM track LIMIT 2 OFFSET 5; ==> 5,6 (该表记录从 0 开始)



高级查询操作
别名
    列别名     AS
        SELECT artist_name AS artists FROM artist;  ==>列名显示为 artists

        合并列     CONCAT(column_name, ['your_words'], ...) AS new_name
        SELECT CONCAT(artist_name, " reconded ", album_name) AS recording FROM
        artist INNER JOIN album USING(artist_id) ORDER BY recording;
        <===>
        SELECT CONCAT(artist_name, " reconded ", album_name) AS recording FROM
        artist INNER JOIN album USING(artist_id) ORDER BY CONCAT(artist_name,
        " reconded ", album_name);
        注意:
            - WRONG!!!!
                SELECT artist_name AS a FROM artist WHERE a = 'New Order';
                原因:
                MySQL 在执行 WHERE 之前，并没有 a 存在，只有artist_name.
                - 列别名不能用于 WHERE, USING, ON 中做条件。
                - 列别名可以用于 GROUP BY, HAVING, ORDER BY, COUNT(), SUM() 等聚合语句
            - AS 可以省略, 下面两个语句查询结果完全相同
                SELECT artist_id AS id FROM artist LIMIT 1;
                SELECT artist_id id FROM artist LIMIT 1;
    表别名
        SELECT ar.artist_id, al.album_name, ar.artist_name FROM album AS al
        INNER JOIN artist AS ar
        USING (artist_id) WHERE al.album_name = "Brotherhood";
        必须指明某表某列
            Wrong: SELECT * FROM album WHERE album_name = album_name
                >得到表的所有记录
            SELECT a1.artist_id, a2.album_id FROM album AS a1, album as a2
            WHERE a1.album_name = a2.album_name
            SELECT a1.artist_id, a2.album_id FROM album AS a1, album as a2
            WHERE a1.album_name = a2.album_name AND a1.artist_id != a2.artist_id
聚合数据
    去重  DISTINCT:
        SELECT DISTINCT artist_name FROM artist INNER JOIN album USING(artist_id);
        SELECT artist_name FROM artist INNER JOIN album USING(artist_id);
    分组  COUNT(), GROUP BY:
        SELECT artist_name, COUNT(artist_name) FROM artist INNER JOIN album USING (artist_id)
        GROUP BY artist_name;
        ==> COUNT() 可以以任意一个属性计数或者放入*，都可以，但是不能什么都不写，即COUNT(*),
        COUNT(artist_name), or COUNT(artist_id) 都是可以的，但是 COUNT()，报错
    聚合函数
        COUNT(), SUM(column_name), MAX(), MIN(), AVG(), STD()，STDDEV(),
        SELECT SUM(time) FROM album INNER JOIN track USING(artist_id, album_id)
        WHERE album.artist_id=1 AND album.album_id=7;
    HAVING 语句
        HAVING 语句，必须含有一个在 SELECT 语句中出现过的表达式(COUNT(), SUM(), MIN(), or MAX())
        或者列。
        如果想写 HAVING 语句，但是发现条件没有出现在 SELECT 中，则很有可能需要写一个 WHERE
        SELECT artist_name, album_name, COUNT(*) FROM artist INNER JOIN album
        USING(artist_id) INNER JOIN track USING(aritst_id, album_id)
        INNER JOIN played USING (artist_id, album_id, track_id)
        GROUP BY album.artist_id, album.album_id
        HAVING COUNT(*) >= 5;
        下面的 HAVING 语句是不应该使用的，效率低于 WHERE 改写的形式
        SELECT artist_name, album_name, COUNT(*) FROM artist INNER JOIN album
        USING (artist_id) INNER JOIN track USING(artist_id, album_id)
        GROUP BY artist.artist_id, album.album_id
        HAVING artist_name = 'New Order';
        改写
        SELECT artist_name, album_name, COUNT(*) FROM artist INNER JOIN album
        USING (artist_id) INNER JOIN track USING(artist_id, album_id)
        WHERE artist_name = 'New Order'
        GROUP BY artist.artist_id, album.album_id;





联合查询 JOIN
    联合条件语句 USING (column_name, ...)
        USING(column_name)
        SELECT artist_name, album_name FROM artist INNER JOIN album USING(artist_id);
        SELECT played, track_name FROM track INNER JOIN played USING (artist_id, album_id,track_id)
        ORDER BY track.artist_id, track.album_id, played;
        注意:
            !!! 省略或者忘记 USING 语句条件，将会返回两个表所有记录间的 Cartesian Product
    联合条件语句 ON column_name_1 = column_name_2
        SELECT artist_name, album_name FROM artist INNER JOIN album
        ON artist.artist_id = album.artist_id;
    内连接查询 INNER JOIN: 给出两表中指定列值相等的记录，若不相等或者缺失则不显示
    左连接 LEFT JOIN: 列出左表(第一个表)符合条件的所有记录，与右表中相应记录联合，若右表中没有
        相应记录，则在相应位置显示为 NULL
        SELECT track_name, played FROM track LEFT JOIN played USING(artist_id,
        album_id, track_id) ORDER BY played DESC;
        SELECT track_name, played FROM played LEFT JOIN track USING (artist_id,
        album_id, track_id) ORDER BY played DESC;
    右连接 RIGHT JOIN:
        ELECT track_name, played FROM track RIGHT JOIN played USING(artist_id,
        album_id, track_id) ORDER BY played DESC;
    自然连接 NATURAL JOIN: 不指明联合条件，MySQL 自动实现连接
        SELECT artist_name, album_name FROM artist NATURAL JOIN album;

    变体:
        LEFT JOIN | RIGHT JOIN === LEFT OUTER JOIN | RIGHT OUTER JOIN
        NATURAL LEFT OUTER JOIN | NATURAL RIGHT OUTER JOIN
        NATURAL LEFT JOIN | NATURAL RIGHT JOIN   <=== No USING | ON 语句

联合查询
    联合  UNION
    SELECT artist_name FROM artist UNION SELECT album_name FROM album
    UNION SELECT track_name FROM track;
    (SELECT track_name FROM track INNER JOIN played USING(artist_id, album_id,
    track_id) ORDER BY played ASC LIMIT 5)
    UNION
    (SELECT track_name FROM track INNER JOIN played USING (artist_id,
    album_id, track_id) ORDER BY played DESC LIMIT 5);
    (SELECT track_name FROM track INNER JOIN played USING(artist_id, album_id,
    track_id) ORDER BY played ASC LIMIT 5)
    UNION
    (SELECT track_name FROM track INNER JOIN played USING(artist_id, album_id,
    track_id) ORDER BY played DESC LIMIT 5);

    保留重复，若结果存在重复记录  UNION ALL
    (SELECT track_name FROM track INNER JOIN played USING(artist_id, album_id,
    track_id))
    UNION ALL
    (SELECT track_name FROM track INNER JOIN played USING(artist_id, album_id,
    track_id)
    ORDER BY played DESC LIMIT 5);
    要对结果排序，必须把 ORDER BY 语句放到最后
    （SELECT artist_name FROM artist WHERE artist_id < 5)
    UNION
    (SELECT artist_name FROM artist WHERE artist_id > 7)
    ORDER BY artist_name LIMIT 4;

子查询 NESTED QUERY | Inner Query | Subquery
    三类: scalar subquery, column subquery, row subquery and  correlated subquery
- scalar subquery
    SELECT artist_name FROM artist WHERE artist_id = (SELECT artist_id FROM album
    WHERE album_name="In A Silent Way");
    SELECT track_name FROM track INNER JOIN played USING(aritst_id, album_id, track_id)
    WHERE played = (SELECT MAX(played) FROM played);
- column subquery
    子句 ANY, SOME, ALL, IN, NOT IN

    - ANY | IN | SOME: 只要一个符合即可 | 元素存在于集合内即可 | 同 ANY

        SELECT engineer_name, years FROM engineer WHERE years > ANY(SELECT years
        FROM producer);
        ==> 大于 ANY，即大于最小的即满足条件，与 SOME 同意
        SELECT producer_name FROM producer WHERE producer_name = ANY (SELECT
        engineer_name FROM engineer);
        ==>此处 =ANY 与 IN 同意; 同理， !=ANY 与 NOT IN 同意.
        ==> SELECT producer_name FROM producer WHERE producer_name IN (SELECT
            engineer_name FROM engineer);
    - ALL: 每一个都要满足测试条件
        SELECT engineer_name, years FROM engineer WHERE years > ALL (SELECT years
        FROM producer);
        ==> 大于所有的 | 每一个，即必须大于最大的
        注意:
        ==>If it is False for any value, it is False
        ==>If it is not False for any value, it is not True unless it is True for
            all values.
            a contains 14, and b contains 1 and NULL ==> Test a is greater than
            ALL values in b, the result is UNKNOWN (neither true nor false)
        ==>If the table in the subquery is empty, the result is always true.
            a contains 14  and b is empty ==> a is greater than b ==> TRUE
- row subquery
    行子查询语句:
        SELECT producer_name, producer.years FROM producer, engineer
        WHERE producer_name = engineer_name AND producer.years = engineer.years;
        SELECT producer_name, years FROM producer WHERE (producer_name, years)
        IN (SELECT engineer_name, years FROM engineer);
        SELECT artist_name, album_name FROM artist, album WHERE (artist.artist_id,
        artist_name, album_name) =(album.artist_id, "New Order", "Brotherhood");
- correlated subquery
    SELECT * FROM artist WHERE EXISTS (SELECT * FROM played);
        ==>The inner query is true, so it will print all records in artist.
    SELECT album_name FROM album WHERE EXISTS (SELECT * FROM artist WHERE
        artist_name="John Coltrane");   ==>Empty. The subquery get nothing, so false
    SELECT album_name FROM album WHERE NOT EXISTS (SELECT * FROM artist WHERE
        artist_name="New Order");   ==>Empty. The subquery is True, but NOT EXISTS

    SELECT artist_name FROM artist WHERE EXISTS (SELECT * FROM album WHERE
        artist.artist_id = album.artist_id GROUP BY artist.artist_id HAVING COUNT(*)>=2);
    SELECT producer_name FROM producer WHERE producer_name IN (SELECT engineer_name
        FROM engineer);
    SELECT producer_name FROM producer WHERE EXISTS (SELECT * FROM engineer WHERE
        producer_name = engineer.name);
    SELECT producer_name FROM producer WHERE producer_name IN (SELECT * FROM engineer
        WHERE producer_name = engineer.name);
    SELECT producer_name FROM producer WHERE producer_name = (SELECT * FROM engineer
        WHERE producer_name = engineer.name);

    FROM
    SELECT producer_name, months FROM (SELECT producer_name, years*12 AS months
        FROM producer) AS prod;
    注意: 下面的写法报错 ==> Every derived table must have its own alias
    SELECT producer_name, months FROM (SELECT producer_name, years*12 AS months
        FROM producer);

    SELECT AVG(albums) FROM (SELECT COUNT(*) AS albums FROM artist INNER JOIN album
        USING(artist_id) GROUP BY artist.artist_id) AS alb;
    SELECT COUNT(*) AS albums FROM artist INNER JOIN album USING (artist_id)
        GROUP BY artist.artist_id;
    注意: 不能级联使用聚合函数，下面的写法会报错
    SELECT AVG(COUNT(*)) FROM album INNER JOIN artist USING(artist_id) GROUP BY
        artist.artist_id;







备份与恢复数据
    bash中:  $mysql -uroot -p databse<table_data.sql
             $mysql -uroot -p <database_data.sql
