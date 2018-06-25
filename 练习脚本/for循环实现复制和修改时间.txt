显示/etc/init.d/functions、/etc/rc.d/rc.sysinit和/etc/fstab各有多少行；并复制三个文件到/tmp目录中，用for循环实现，分别将每个文件的最近一次的修改时间改为2011年9月15号13点27分；

#!/bin/bash
for i in /etc/{init.d/functions,rc.d/rc.sysinit,fstab};do
  wc -l $i
  cp $i /tmp
  touch -m -t 201109151327 /tmp/`basename $i`
done