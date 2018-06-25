读写锁

读锁  Read lock
    A read lock allows you to prevent other users from changing data while you
    are reading and processing the data.

写锁  Write lock
    A write lock tells others that the data is being changed and that they should
    not read or modify it.

事务  Transcation
    Allow you to batch together SQL statements as an individual set that either
    succeeds or has no effect on the database.

    COMMIT | ROLLBACK

事务安全表   Transaction-safe tables (TSTs): InnoDB      Berkeley Database(Dead)
    支持事务操作

事务不安全表  Non-Transaction-safe tables (NTSTs):    MyISAM, Merge, Memory
    不支持事务，但是查询速度快，占用资源少(包括硬盘和内存)，简单易用
    
    事务例子:
        START TRANSATION;
        INSERT INTO artist VALUES(7, 'The Cure');
        INSERT INTO album VALUES (8, 1, "Disintegration");
        COMMIT | ROLLBACK;
