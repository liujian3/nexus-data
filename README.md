# setup nexus
git clone https://github.com/liujian3/nexus-data.git

chmod -R 777 nexus-data

docker run -it -p 8081:8081 --rm --name nexus -v /root/nexus-data:/nexus-data sonatype/nexus3:3.34.1

# login
username:admin

password:admin

# server
## npm
### run
docker run -it node:14.18.1-slim bash
### config
npm config set registry http://192.168.0.$A:8081/repository/npm-proxy/

yarn config set registry http://192.168.0.$A:8081/repository/npm-proxy/
## python
### run
docker run -it python:3.9 bash
### config
pip config set global.index-url https://192.168.65.75/repository/pypi-proxy/
# windows
## npm
### run
docker run -it node:10.16.0 bash
### config
npm install yarn -g

npm config set user-agent "npm/6.9.0 node/v10.16.0 win32 x64"

yarn config set user-agent "yarn/1.22.10 npm/? node/v10.16.0 win32 x64"

npm config set registry http://192.168.0.$A:8081/repository/npm-proxy/

yarn config set registry http://192.168.0.$A:8081/repository/npm-proxy/
