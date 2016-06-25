#!/bin/bash -x


##Removing stopped container

docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm

##If you do not want to remove all container you can have filter for days and weeks old like below
#docker ps -a | grep Exited | grep "days ago" | awk '{print $1}' | xargs docker rm
#docker ps -a | grep Exited | grep "weeks ago" | awk '{print $1}' | xargs docker rm

##Removing Dangling images
##There are the layers images which are being created during building docker image. This is a great way to recover the spaces used by old and unused layers.

docker rmi $(docker images -f "dangling=true" -q)

##Removing images of perticular pattern For example
##Here i am removing images which has SNAPSHOT with it.

docker rmi $(docker images | grep SNAPSHOT | awk '{print $3}')

##Removing Weeks old images

docker images | grep "weeks ago" | grep -v ubuntu | grep -v alpine | grep -v java | awk '{print $3}' | xargs docker rmi

##Similarly You can remove days, months old images too.

