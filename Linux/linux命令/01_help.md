线上查询及帮助命令(2个)

man     查看命令帮助，命令的词典，更复杂的还有info，但不常用。
    9 section
        1. 用户命令
        2. 系统调用
        3. 库调用
        4. 特殊文件(设备)
        5. 文件格式(配置文件的格式)
        6. 游戏
        7. 杂项
        8. 管理命令
        9. 内核   kernel routines [Non standard]

help    查看Linux内置命令的帮助，比如cd命令。
    $help  builtin_name

COMMNAD --help: 获取外部命令的帮助信息

info: 提供命令的信息, 作为 man 的补充

/usr/share/doc: 系统自带的帮助文档

type    显示给定的 Linux 命令的信息, 如别名，shell 内置命令，文件，函数或者关键字；
        显示命令的实际路径
    $type ls    ==> ls is alias to 'ls --color=auto'

    -t  仅显示命令类型       $type -t ls | pwd | mkdir | if | rvm
    -p  显示命令的绝对路径   $type -p cal
    -a  显示命令的所有信息   $type -a ls
