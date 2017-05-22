export ES_JAVA_OPTS="-Xms4g -Xmx4g"
NUM_CPU=`cat /proc/cpuinfo | grep "processor" | wc -l`

OPTIONS="-Ecluster.name=elasticsearch -Enode.master=true"
OPTIONS="${OPTIONS} -Ediscovery.initial_state_timeout=3m -Ediscovery.zen.minimum_master_nodes=2 -Egateway.recover_after_time=2m"
OPTIONS="${OPTIONS} -Ethread_pool.index.size=$NUM_CPU"
OPTIONS="${OPTIONS} -Ethread_pool.index.queue_size=1000"
OPTIONS="${OPTIONS} -Ethread_pool.bulk.size=$NUM_CPU"
OPTIONS="${OPTIONS} -Ethread_pool.bulk.queue_size=1000"
OPTIONS="${OPTIONS} -Ethread_pool.search.size=$NUM_CPU"
OPTIONS="${OPTIONS} -Ethread_pool.search.queue_size=1000"
OPTIONS="${OPTIONS} -Ethread_pool.get.size=$NUM_CPU"
OPTIONS="${OPTIONS} -Ethread_pool.get.queue_size=1000"
OPTIONS="${OPTIONS} -Ebootstrap.memory_lock=false"
OPTIONS="${OPTIONS} -Enetwork.host=0.0.0.0"
OPTIONS="${OPTIONS} -Ehttp.port=9200"
OPTIONS="${OPTIONS} -Etransport.host=0.0.0.0"
OPTIONS="${OPTIONS} -Etransport.tcp.port=9300"
OPTIONS="${OPTIONS} -Ediscovery.zen.ping.unicast.hosts=${DISCOVERY_HOSTS}"
OPTIONS="${OPTIONS} -Expack.security.enabled=false"

if [ "x$VERSION" != "x" ]; then
    echo "ElasticSearch VERSION = $VERSION"
    
    bash  elasticsearch-${VERSION}/bin/elasticsearch -Enode.name=master${HOSTNAME} -Epath.data=master${HOSTNAME}_data -Epath.logs=master${HOSTNAME}_logs -Ehttp.cors.enabled=true -Ehttp.cors.allow-origin=* -Ehttp.cors.allow-headers=Authorization ${OPTIONS} |tee master${HOSTNAME}.log
    echo "ElasticSearch started."
    
else
    echo "ElasticSearch VERSION is not specify, skip."
fi
