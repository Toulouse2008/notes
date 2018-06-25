
选项文件    ~/.my.cnf

    [server | mysqld | mysql_safe]
    user=root
    host=adr.learningmysql.com
    port=58888
    user=allmusic
    database=music
    ==>password=your_password
    basedir=/usr/local/mysql-standard-5.1.22-linux-i86
    socket=/home/mysql/server1.sock
    datadir=/home/mysql/data
    tmpdir=/home/mysql/tmp
    pid_file=/home/mysql/logs/server1.pid

    #log server messages to:
    log=/home/mysql/logs/server1.main.log
    #log errors to this:
    log_error=/home/mysql/logs.server1.error.log
    #log updates to this binary logfile
    log_bin=/home/mysql/logs/server1.updates.bin

    [client]
    socket=/home/mysql/server1.sock

    [mysql]
    database=mysql

    [mysqldump]
    all-databases
    result_file=/tmp/dump.sql

    $mysqladmin status
    $mysql --defaults-file=/path/to/out.sql
    $mysql --defaults-extra-file=/path/to/out.sql
    $mysql --no-defaults
    $mysqldump --print-defaults
    $my_print_defaults client mysqldump
