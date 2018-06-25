GRANT
创建用户
    - 库级权限用户    <==用户只能看music库和test库，若test存在
    GRANT ALL ON music.* TO 'allmusic'@'localhost' IDENTIFIED BY 'the_password';
    - 表级权限用户    <==用户只能看artist表
    GRANT ALL ON music.artist TO 'partmusic'@'localhost' IDENTIFIED BY 'pass';
    - 列级权限用户    <==用户只能看 track_id 和 time
    GRANT SELECT(track_id, time) ON music.track TO 'user'@'localhost' IDENTIFIED
    BY 'pass';

授予权限
    - 全局权限  Global Level    服务器上的所有数据库  ON *.*
    - 库级权限  Database level  指定数据库的所有表 music.*
    - 表级权限  Table level     特定表的权限      music.album
    - 列级权限  Column level    特定列的权限  GRANT SELECT (album_name) ON music.album;

    GRANT ALL ON music.* TO 'hugh'@'localhost';
    GRANT GRANT OPTION ON music.* TO 'hugh'@'localhost';    <== 用户没有密码
    GRANT OPTION: 用户具有类似管理员权限，即可以授予其他人权限

    GRANT ALL ON *.* TO 'hugh'@'localhost' IDENTIFIED BY 'pass';
    $mysql --user=hugh --host=127.0.0.1 --password=pass

    创建远程用户
    GRANT ALL ON *.* TO 'hugh'@'192.168.1.2' IDENTIFIED BY 'PASS';  // --host=192.168.1.2
    GRANT ALL ON *.* TO 'hugh'@'rack.invy.com' IDENTIFIED BY 'PASS'; //--host=rack.invy.com
    使用通配符
    GRANT ALL ON *.* TO 'hugh'@'%.invy.com' IDENTIFIED BY 'PASS';
    GRANT ALL ON *.* TO 'hugh'@'192.168.1.%' IDENTIFIED BY 'PASS';

    匿名用户
    GRANT SELECT ON music.* TO ''@'localhost';
    $mysql
    mysql>SELECT CURRENT_USER();    ==>@localhost

    GRANT DELETE, INSERT, SELECT, UPDATE, LOCK TABLES ON music.* TO 'musicuser'@
    'localhost' IDENTIFIED BY 'pass';

查看权限
    SHOW GRANTS;    <== 显示当前用户的权限
    SHOW GRANTS FOR 'user_name'@'localhost';
    SHOW GRANTS FOR 'partmusic'@'localhsot';
    SHOW GRANTS FOR 'fred'@'%';

收回权限    REVOKE
    REVOKE SELECT (time) ON music.track FROM 'partmusic'@'localhost';
    REVOKE SELECT (track_id) ON music.track FROM 'partmusic'@'localhost';
    REVOKE ALL PRIVILEGES ON music.artist FROM 'partmusic'@'localhost';
    REVOKE ALL PRIVILEGES ON music.album FROM 'partmusic'@'localhost';

删除用户    DROP USER
    ==> DROP USER 'partmusic'@'localhost';
    ==> DELETE FROM mysql.user WHERE User='partmusic' and Host='localhost';
    ==> FLUSH PRIVILEGES;

理解密码    PASSWORD()
    SELECT PASSWORD('The_password');
    SELECT OLD_PASSWORD('The_password');
    设置密码的方法
        - 授予权限是设定密码
            GRANT ALL ON music.* TO 'selina'@'localhost' IDENTIFIED BY 'PASS';
        - 用户已经存在了，GRANT USAGE
            GRANT USAGE ON *.* TO 'selina'@'localhost' IDENTIFIED BY 'PASS';
        - 用户已经存在，用 SET PASSWORD 重置密码
            SET PASSWORD=PASSWORD('your_password');
            SET PASSWORD FOR 'selina'@'localhost' = '';  <==设置密码为空
            SET PASSWORD FOR 'selina'@'localhost' = 'pass';
        - 更新用户表，设置密码
            UPDATE mysql.user SET Password=PASSWORD('The_new_pass') WHERE user='selina';
        - mysqladmin 重置用户密码
    	   mysqladmin password()
    	$ mysqladmin --user=your_mysql_username --password=your_old_mysql_password password "your new mysql password"

        自己hash, The PASSWORD keyword stores the hashed string directly, rather
        than passing it through the PASSWORD() function.
    	mysql> GRANT USAGE ON *.* TO 'partmusic'@'localhost'
        IDENTIFIED BY PASSWORD '*14E65567ABDB5135D0CFD9A70B3032C179A49EE7';
    	You can also manually set a password to its hashed version by using the
        SET PASS WORD statement without the PASSWORD() function as follows
    	mysql> SET PASSWORD FOR 'partmusic'@'localhost' ='*14E65567ABDB5135D0CFD9A70B3032CE7'

        ==>更改用户密码

        ==>用已有的密码，授予新权限
            GRANT USAGE ON *.* TO 'partmusic'@'localhost' IDENTIFIED BY
                PASSWORD '*the_hash_code';
            SET PASSWORD FOR 'partmusic'@'localhost'='*the_hash_code';

忘记root密码
    方案一
        - 关掉服务器
            $kill 'cat MySQL_Directory/data/your_host_name.pid'
        - 创建一个含有设置新密码的SQL语句的文件, reset_rootpass.sql
            SET PASSWORD FOR 'root'@'localhost'=PASSWORD('your_new_word');
        - 安全模式启动 mysql
            $mysqld_safe --init-file=/path/to/reset_rootpass.sql &
    方案二
        - 关掉服务器
        - 启动 msyql 时， 跳过授权表，即关闭授权检查
            $mysqld_safe --skip-grant-tables
        - 立即启动授权表
            mysql>FLUSH PRIVILEGES;
        - 重新设置root密码
            mysql>UPDATE mysql.user SET Password = PASSWORD('new_pass') WHERE
                User = 'root';
            OR:
            mysql>SET PASSWORD FOR 'root'@'localhost'=PASSWORD('new_pass');

            MySQL 5.7 中，password字段被authentication_string所替代

        - 更新权限
            mysql>FLUSH PRIVILEGES;
        - 退出客户端
            mysql> QUIT;
    方案三
        - 关闭mysql服务器
        - 编辑 /etc/my.cnf, 在[mysqld]下加上如下
            skip-grant-tables
        - 启动mysql   service mysqld start | systemctl start mysqld
        - 登陆mysql  $mysql   #不需要用户和密码
            update user set authentication_string=password('2011') where user='root' OR user='frank';
        - 刷新权限    mysql>flush privileges;
        - 关闭mysql服务器
        - 把加入的哪行comment掉或者删除
        -重启服务器即可

SELECT User, Host FROM mysql.user;
SHOW GRANTS FOR 'root'@'localhost';
SHOW GRANTS FOR ''@'localhsot';

安全设置:
    - 必须设置用户密码
    - 删除test库的权限
    - 删除所有的匿名用户
    - 禁止远程登录
        DELETE FROM mysql.user WHERE Host <> 'localhost';

资源控制
    MAX_QUERIES_PER_HOUR, MAX_UPDATE_PER_HOUR, MAX_CONNECTIONS_PER_HOUR
    GRANT USAGE ON *.* 'partmusic'@'localhsot' WITH
    MAX_QUERIES_PER_HOUR 100, MAX_UPDATE_PER_HOUR 10, MAX_CONNECTIONS_PER_HOUR 5;

ALTER, FILE, CREATE, DROP, INDEX, GRANT OPTION, PROCESS, SHUTDOWN

通过 SQL client 管理权限
	1. 全局权限 ==> 用户表 mysql.user
			The user table manages users and global privileges
		mysql> USE mysql；
		mysql> SELECT * FROM user WHERE User = 'fred';
	2. 库权限 ==> 库表 mysql.db
			db table manages privileges for a particular database
		mysql> GRANT SELECT, INSERT, DELETE on music.* TO 'bob'@'localhost';
		mysql> SELECT * FROM db WHERE User = 'bob';
	3. 表级权限 ==> 表权限表  table_priv
			The tables_priv table stores privileges for the table level.
		mysql> GRANT INDEX on music.artist TO 'bob'@'localhost';
		mysql> SELECT * FROM tables_priv WHERE User = 'bob';
		mysql> GRANT UPDATE (album_name) ON music.album TO 'bob'@'localhost';
		mysql> SELECT * FROM tables_priv WHERE User = 'bob';
	4. 列级权限 ==> 列权限表 columns_priv
			The columns_priv table lists which privileges are available for which
            columns. It’s only accessed if the tables_priv table says that a
            privilege is available for one or more columns in a table and that
            privilege isn’t already available at the table level.
		mysql> SELECT * FROM columns_priv WHERE User = 'bob';

	5. 主机表 host Table
		需求
			1. when sam accesses the server from the localhost, you want him to
                have all privileges for the database except GRANT OPTION.
			2. when he accesses the server from anywhere else on your network
                subnet—which is all machines matching 192.168.1.%—you want him
                to have all simple non-administrator privileges.
			3. when he connects from anywhere else, you want him to have the
                SELECT privilege only.
		方案一
			By creating three users that that have access to
            music.*: 'sam'@'localhost', 'sam'@'192.168.1.%, and 'sam'@'%'.
		方案二 modify host table
			mysql> GRANT ALL ON music.* TO 'sam'@'' IDENTIFIED BY 'p^R5wrD';
				Notice that we’ve given the privileges to 'sam'@'', which sets
                the Host column value to the empty string; don’t use just 'sam'
                because this is the same as 'sam'@'%'. We’ve also set this user’s
                password to 'p^R5wrD'.
			mysql> DESCRIBE host;
			mysql> INSERT INTO host VALUES ('localhost', 'music','Y','Y','Y',
                'Y','Y','Y', 'Y','Y','Y','Y','Y','Y');
			mysql> FLUSH PRIVILEGES;
			mysql> INSERT INTO host VALUES ('192.168.1.%','music', 'Y','Y','Y',
                'Y','N','N', 'N','N','N','N','N','Y');
			mysql> INSERT INTO host VALUES ('%', 'music','Y','N','N','N','N','N',
                'N', 'N','N','N','N','N');
			mysql> INSERT INTO host VALUES ('192.168.1.200', '%','N','N','N','N',
                'N','N', 'N','N','N','N','N','N');

	The server verifies that users have authorization to perform an operation by
	checking the global privileges listed for them in the user table. If they don’t
	have the required privilege for all databases, then the server checks the db
    table to see whether they have that privilege for the active database. If the
    Host field in the db table is blank, the user’s privileges for the database
    vary depending on the host they’re connecting from. These privileges are
    stored in the host table and are verified against the global settings in the
    db table to determine the privileges for a database when it’s accessed from
    a client.
