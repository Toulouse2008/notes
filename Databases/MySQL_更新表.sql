更新表内容
    完整记录的插入
        INSERT INTO tb_name VALUES(value_list),(value_list);
        向表内插入一条记录的流程
            1. 查看表结构
                SHOW COLUMNS FROM artist;
            2. 查看最近一次插入的 id 号
                SELECT MAX(artist_id) FROM artist;
            3. 按表结构要求插入记录
                INSERT INTO artist VALUES(7, "Barry Adamson");
        一次插入多条记录
            INSERT INTO artist values(8, 'Erric error'), (9, 'Bitten bite');

        另一种格式
            INSERT INTO played SET artist_id = 1, album_id = 3, track_id = 0,
            played = '2006-08-12 10:27:03';

    只插入指定列的值
        INSERT INTO tb_name (column_name,...) VALUES(value_list),(value_list);
        eg
        INSERT INTO played(artist_id, album_id, track_id) VALUES (7,1,1);
        INSERT INTO played() VALUES();  ==>插入时使用默认值

    更新记录内容
        UPDATE artist SET artist_name = UPPER(artist_name);

    删除记录
        DELETE
            DELETE FROM tb_name WHERE condition_list;
            注意: 如果没有条件，则表的内容会被清空
        TRUNCATE:
            TRUNCATE tb_name;
        DELETE 和 TRUNCATE 对比:
            - 清空表时，TRUNCATE 比 DELETE 更快，
              TRUNACATE 执行的是 DROP TABLE tb_name, CREATE TABLE
              DELETE 执行的行删除
            - 如果有 AUTO INCREMENT 设定的列，TRUNCATE 会将其清零，而 DELETE 不会

更新表结构
    增加、删除、更改列
    ALTER TABLE tb_name {ADD | MODIFY | CHANGE | DROP} column_name [definition]

    - 修改列名称: 表名，列名，新列名，列定义，四个缺一不可
        ALTER TABLE played CHANGE played last_played TIMESTAMP;
        ALTER TABLE artist CHANGE artsit_name artist-name CHAR(64) DEFAULT NULL;
    - 修改列的定义
        ALTER TABLE artist MODIFY artist_name CHAR(64) DEFAULT 'Unknown';
    - 增加列
        ALTER TABLE artist ADD formed YEAR [FIRST | LAST | AFTER col_name];
        ALTER TABLE artist ADD formed YEAR; <==默认添加为最后一列
        ALTER TABLE artist ADD formed YEAR FIRST; <==作为第一列插入
        ALTER TABLE artist ADD formed YEAR AFTER artist_id; <==插入到指定列后面
    - 删除列
        ALTER TABLE artist DROP formed;

        ALTER TABLE artist ADD formed YEAR FIRST, MODIFY artist_name CHAR(256);
替换数据
    - 按主键先删除，再插入新的
    - 按主键更新
    - 替换 REPLACE
        mysql>REPLACE artist VALUES(2, 'Nick cave and The bad seeds');
        - 如果主键标识还不存在，REPLACE 和 INSERT 完全相同
        - INSERT IGNORE ==> 保持原有数据，忽略新数据; REPLACE==>删除原记录，插入新数据
索引的添加、更改、删除
    - 添加索引
        索引: ALTER TABLE artist ADD INDEX by_name(artist_name);
        主键: ALTER TABLE artist ADD PRIMARY KEY (artist_id);
    - 删除索引
        索引: ALTER TABLE artist DROP INDEX by_name;
        主键: ALTER TABLE artist DROP PRIMARY KEY;

通过 SELECT 语句插入数据
    INSERT INTO shuffle(artist_id, album_id, track_id) SELECT artist_id, album_id,
    track_id FROM track ORDER BY RAND() LIMIT 10;
    ==>注意: 此处不能用 VALUES， 用了反而报错

通过查询语句建表
    mysql> CREATE TABLE art LIKE artist;    <== 空表，结构同 artist
    mysql> CREATE TABLE art2 SELECT * FROM artist; <== art2 和 artist 结构内容均相同
    CREATE TABLE report (artist_name CHAR(128), album_name CHAR(128)) SELECT
    artist_name, album_name FROM artist INNER JOIN album USING(aritst_id);
        ==>这种方式建立的表，保留原表中的主键(Primary Key),
            但是不复制原表中的 索引(INDEX) 和 外键(Foreign Key)

    CREATE TABLE artist-1 (UNIQUE(artist_id)) SELECT * FROM artist;
    CREATE TABLE artist-2 (artist_id SMALLINT(5) NOT NULL AUTO_INCREMENT,
        artist_name CHAR(128) NOT NULL DEFAULT "New Order",
        PRIMARY KEY(artist_id), KEY(artist_name))
        SELECT * FROM artist;


载入csv文件中的数据
    mysql>LOAD DATA INFILE '/path/to/file.csv' INTO tb_name FIELDS TERMINATED BY ',';
数据写入csv文件
    mysql>SELECT artist_name, album_name FROM artist, album WHERE artist.artist_id
        = album.artist_id INTO OUTFILE '/path/to/data.csv' FIELDS TERMINATED BY ',';
