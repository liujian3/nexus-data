# setup nexus
git clone https://github.com/liujian3/nexus-data.git

chmod -R 777 nexus-data

docker run -d -p 8081:8081 --rm --name nexus -v /root/nexus-data:/nexus-data sonatype/nexus3
# login
username:admin

password:admin
# run node
docker run -it node:10.16.0 bash
# setup npm
npm install yarn -g
npm config set user-agent "npm/6.9.0 node/v10.16.0 win32 x64"
yarn config set user-agent "yarn/1.22.10 npm/? node/v10.16.0 win32 x64"
npm config set registry http://192.168.0./repository/npm-proxy/
yarn config set registry http://192.168.0./repository/npm-proxy/
