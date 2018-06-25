17 张表
    user, db, tables_priv, columns_priv, and host

- user 表
    manage users and global privileges
    Columns:
        - User, Password, Host,
        - Previliges:
          [Select, Insert, Update, Delete, Create, Drop, Reload, Shutdown, Process,
          File, Grant, References, Index, Alter, Show_db, Super, Create_tmp_table,
          Lock_tables, Execute, Repl_slave, Repl_client, Create_view, Show_view,
          Create_routine, Alter_routine, Create_user]_priv
          ssl_type, ssl_cipher, x509_issuer, x509_subject, max_queries, max_updates,
          max_connections, max_user_connections

- db 表
    保存库级的权限。When you grant privileges for a particular database, they are
    stored in the db table of the mysql database.
    SELECT * FROM db WHERE User='bob;'

- table_priv 表
    保存表级别的权限

- columns_priv 表
    保存列级的权限


- Host 表
