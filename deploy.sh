#!/bin/bash
docker build -t casteem/express-rest-es2017-boilerplate .
docker push casteem/express-rest-es2017-boilerplate

ssh deploy@$DEPLOY_SERVER << EOF
docker pull casteem/express-rest-es2017-boilerplate
docker stop api-boilerplate || true
docker rm api-boilerplate || true
docker rmi casteem/express-rest-es2017-boilerplate:current || true
docker tag casteem/express-rest-es2017-boilerplate:latest danielfsousa/express-rest-es2017-boilerplate:current
docker run -d --restart always --name api-boilerplate -p 3000:3000 casteem/express-rest-es2017-boilerplate:current
EOF
