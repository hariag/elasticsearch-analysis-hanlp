#sysctl -w vm.max_map_count=262144

VM_MAX_MAP_COUNT=`grep "vm.max_map_count=655360" /etc/sysctl.conf `
if [ "x$VM_MAX_MAP_COUNT" != "x" ]; then
    echo $VM_MAX_MAP_COUNT
else
    echo "vm.max_map_count=655360" >> /etc/sysctl.conf 
    sysctl -p
fi

NOFILE=`grep "DefaultLimitNOFILE=65535" /etc/systemd/system.conf`
if [ "x$NOFILE" != "x" ]; then
    echo $NOFILE
else
    echo "DefaultLimitNOFILE=65535" >> /etc/systemd/system.conf
fi

SOFT_LIMITS=`grep "* soft memlock unlimited" /etc/security/limits.conf`
if [ "x$SOFT_LIMITS" != "x" ]; then
    echo $SOFT_LIMITS
else
    echo "* soft memlock unlimited" >> /etc/security/limits.conf
fi

HARD_LIMITS=`grep "* hard memlock unlimited" /etc/security/limits.conf`
if [ "x$HARD_LIMITS" != "x" ]; then
    echo $HARD_LIMITS
else
    echo "* hard memlock unlimited" >> /etc/security/limits.conf
fi

SOFT_NOFILE_LIMITS=`grep "* soft nofile 65536" /etc/security/limits.conf`
if [ "x$SOFT_NOFILE_LIMITS" != "x" ]; then
    echo $SOFT_NOFILE_LIMITS
else
    echo "* soft nofile 65536" >> /etc/security/limits.conf
fi

SOFT_NPROC_LIMITS=`grep "* soft nproc 65536" /etc/security/limits.conf`
if [ "x$SOFT_NPROC_LIMITS" != "x" ]; then
    echo $SOFT_NPROC_LIMITS
else
    echo "* soft nproc 2048" >> /etc/security/limits.conf
fi

HARD_NOFILE_LIMITS=`grep "* hard nofile 131072" /etc/security/limits.conf`
if [ "x$HARD_NOFILE_LIMITS" != "x" ]; then
    echo $HARD_NOFILE_LIMITS
else
    echo "* hard nofile 131072" >> /etc/security/limits.conf
fi

HARD_NPROC_LIMITS=`grep "* hard nproc 4096" /etc/security/limits.conf`
if [ "x$HARD_NPROC_LIMITS" != "x" ]; then
    echo $HARD_NPROC_LIMITS
else
    echo "* hard nproc 4096" >> /etc/security/limits.conf
fi

