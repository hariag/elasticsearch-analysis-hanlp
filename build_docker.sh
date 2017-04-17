docker build -t haria/elasticsearch_analysis_hanlp:1.0 .
sudo docker run --privileged=true -it haria/elasticsearch_analysis_hanlp:1.0

# sudo docker ps -a
# sudo docker rmi IMAGE_ID
# sudo docker rm CONTAINER_ID
# sudo docker ps -a|cut -d " " -f1|xargs -i sudo docker rm {}
# sudo docker save IMAGE_ID > archive.tar
# sudo docker load < archive.tar
