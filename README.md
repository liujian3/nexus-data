# setup nexus
git clone https://github.com/liujian3/nexus-data.git

chmod -R 777 nexus-data

docker run  --ulimit nofile=65536:65536 -it -p 8081:8081 --rm --name nexus -v /root/nexus-data:/nexus-data sonatype/nexus3:3.34.1

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
docker run -it python:3.9-slim bash
### config
pip config set global.index http://192.168.0.$A:8081/repository/pypi-proxy/pypi

pip config set global.index-url http://192.168.0.$A:8081/repository/pypi-proxy/simple
## r
### run
docker run -it r-base:4.1.1 bash
### config
echo '## Default repo'>.Rprofile

echo 'local({r <- getOption("repos")'>>.Rprofile

echo '  r["Nexus"] <- "http://192.168.0.'$A':8081/repository/r-proxy"'>>.Rprofile
  
echo '  options(repos=r)'>>.Rprofile
  
echo '})'>>.Rprofile
## apt
### run
### config
echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal main restricted' > /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal-updates main restricted' >> /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal universe' >> /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal-updates universe' >> /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal multiverse' >> /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal-updates multiverse' >> /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal-backports main restricted universe multiverse' >> /etc/apt/sources.list
## conda
### run
### config
echo 'channels:' > /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/main' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/r' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/free' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/mro' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/pro' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/archive' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/mro-archive' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/msys2' >> /opt/conda/.condarc

echo 'auto_update_conda: False' >> /opt/conda/.condarc

echo 'repodata_fns:' >> /opt/conda/.condarc

echo ' - repodata.json' >> /opt/conda/.condarc
## yum
### run
### config
echo '[nexus_baseos]' > /etc/yum.repos.d/nexus.repo

echo 'name=Nexus Repository BaseOS' >> /etc/yum.repos.d/nexus.repo

echo 'baseurl=http://192.168.0.'$A':8081/repository/yum-proxy/$releasever/BaseOS/$basearch/os/' >> /etc/yum.repos.d/nexus.repo

echo 'enabled=1' >> /etc/yum.repos.d/nexus.repo

echo 'gpgcheck=0' >> /etc/yum.repos.d/nexus.repo

echo '[nexus_appstream]' >> /etc/yum.repos.d/nexus.repo

echo 'name=Nexus Repository AppStream' >> /etc/yum.repos.d/nexus.repo

echo 'baseurl=http://192.168.0.'$A':8081/repository/yum-proxy/$releasever/AppStream/$basearch/os/' >> /etc/yum.repos.d/nexus.repo

echo 'enabled=1' >> /etc/yum.repos.d/nexus.repo

echo 'gpgcheck=0' >> /etc/yum.repos.d/nexus.repo

echo '[nexus_extras]' >> /etc/yum.repos.d/nexus.repo

echo 'name=Nexus Repository Extras' >> /etc/yum.repos.d/nexus.repo

echo 'baseurl=http://192.168.0.'$A':8081/repository/yum-proxy/$releasever/extras/$basearch/os/' >> /etc/yum.repos.d/nexus.repo

echo 'enabled=1' >> /etc/yum.repos.d/nexus.repo

echo 'gpgcheck=0' >> /etc/yum.repos.d/nexus.repo

yum clean all && yum makecache
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
