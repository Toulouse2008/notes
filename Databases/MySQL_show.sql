
MYSQLSHOW: display database, table, and columns information
    mysqlshow [options] [db_name [tb_name [column_name]]]
$mysqlshow -uroot -p    ==>显示服务器上的所有数据库
$mysqlshow -uroot -p music      ==>显示 music 库下的所有表
$mysqlshow -uroot -p music track    ==>显示music库中track表的结构
$mysqlshow -uroot -p music track track_name   ==>显示music库中track表中track_name的信息
    （Field, Type, Collation, Null, Key, Default, Extra, Privileges, Comment)



SHOW [CHARACTER SET | COLLATION];

显示表状态: SHOW TABLE STATUS;  <==显示一个数据库下所有表的定义信息
显示表引擎: SHOW ENGINES;    <==显示当前可用的表引擎类型
例子:
    CREATE TABLE mytable (field int(2)) <type | ENGINE > = <Memory | MyISAM>;
    ALTER TABLE artist <type | ENGINE> = InnoDB;

表引擎
    - MyISAM: fast query, low overhead for changes to data,
        查询快，耗费资源少，提供表级锁
    - InnoDB: heavy weight, reliable, high-performance choice for large-scale,
              highly reliable applications.
              transaction-safe, reliable, flexible for high-end applications.
        - Transaction
        - Advanced crash recovery features, recover effectively from power loss,
            crashes, and other basic database failures. Not machine loss or disk
        - Row level locking
        - Foreign-key support
        - Fast, flexible indexing

        cons: more to understand; difficult to setup, disk-hungry, locking-overheads

查看sql语句的执行过程    EXPLAIN
    EXPLAIN SELECT * FROM artist;
    EXPLAIN SELECT * FROM artist INNER JOIN album USING(artist_id);

事务例子:
    START TRANSATION;
    INSERT INTO artist VALUES(7, 'The Cure');
    INSERT INTO album VALUES (8, 1, "Disintegration");
    COMMIT | ROLLBACK;
