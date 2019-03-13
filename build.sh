#!/bin/bash

exec 3>&1 # make stdout available as fd 3 for the result
exec 1>&2 # redirect all output to stderr for logging

#buffer=$(cat)

#Extract variables from json
serviceName=concourse-cd
nodeName=m6kds6ucg5t1gfksfhf5t73la
swarmMasterIp=192.168.40.113
repository=https://github.com/extcrohan/concourse.git
overlay=ingress
#accessKeyId=$(echo $buffer | jq -r '.source.accessKeyId')
#secretAccessKey=$(echo $buffer | jq -r '.source.secretAccessKey')

export DOCKER_HOST="tcp://192.168.40.113:3376"

docker stop concourse-cd
docker rm concourse-cd

docker pull rohanaloha/concourse-deploy-demo

docker run -d -p 8000:80 --restart=always --name=concourse-cd --net=ingress --env=constraint:node==m6kds6ucg5t1gfksfhf5t73la rohanaloha/concourse-deploy-demo
