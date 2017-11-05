#!/bin/bash
docker build -t osamabari/node-rest-boilerplate .
docker push osamabari/node-rest-boilerplate

ssh deploy@$DEPLOY_SERVER << EOF
docker pull osamabari/node-rest-boilerplate
docker stop api-boilerplate || true
docker rm api-boilerplate || true
docker rmi osamabari/node-rest-boilerplate:current || true
docker tag osamabari/node-rest-boilerplate:latest osamabari/node-rest-boilerplate:current
docker run -d --restart always --name api-boilerplate -p 3000:3000 osamabari/node-rest-boilerplate:current
EOF
