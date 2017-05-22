ps aux|grep cluster.name=elasticsearch|awk -F" " '{print $2};'|xargs -i kill -SIGTERM {}
ps aux|grep kibana|awk -F" " '{print $2};'|xargs -i kill -SIGTERM {}

