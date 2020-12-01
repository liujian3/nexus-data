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
npm config set registry http://127.0.0.1:8081/repository/npm-proxy/
