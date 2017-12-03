# Clean up docker host/Delete everything
    docker rm -f $(docker ps -a | awk "{print \$1}")
    docker rmi -f $(docker images | awk "{print \$3}")
    docker run -v /var/run/docker.sock:/var/run/docker.sock -v /data/docker:/var/lib/docker --rm martin/docker-cleanup-volumes
