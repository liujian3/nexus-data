# setup nexus
rm -rf nexus-data

git clone -b main https://github.com/liujian3/nexus-data.git

chmod -R 777 nexus-data

docker run  --ulimit nofile=65536:65536 -it -p 8081:8081 --rm --name nexus -v /root/nexus-data:/nexus-data sonatype/nexus3:3.34.1

# login
username:admin

password:admin

# server
## npm
### run
docker run -it node:16.13-slim bash
### config
npm config set registry http://192.168.0.$A:8081/repository/npm-proxy/

yarn config set registry http://192.168.0.$A:8081/repository/npm-proxy/
## python
### run
docker run -it python:3.9-slim bash
### config
pip config set global.index http://192.168.0.$A:8081/repository/pypi-proxy/pypi

pip config set global.index-url http://192.168.0.$A:8081/repository/pypi-proxy/simple
## conda
### run
docker run -it --rm continuumio/miniconda3:4.10.3p0 bash
### config
echo 'channels:' > /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/main' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/r' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/free' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy2/conda-forge' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy2/anaconda' >> /opt/conda/.condarc
 
echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/mro' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/pro' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/archive' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/mro-archive' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy/msys2' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy2/main' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy2/r' >> /opt/conda/.condarc

echo ' - http://192.168.0.'$A':8081/repository/conda-proxy2/free' >> /opt/conda/.condarc

echo 'channel_alias: http://192.168.0.'$A':8081/nexus/repository' >> /opt/conda/.condarc

echo 'auto_update_conda: false' >> /opt/conda/.condarc

echo 'repodata_fns:' >> /opt/conda/.condarc

echo ' - repodata.json' >> /opt/conda/.condarc
## r
### run
docker run -it r-base:4.1.1 bash
### config
echo 'local({r <- getOption("repos")'>/root/.Rprofile

echo '  r["CRAN"] <- "http://192.168.0.'$A':8081/repository/r-proxy"'>>/root/.Rprofile
  
echo '  options(repos=r)'>>/root/.Rprofile
  
echo '})'>>/root/.Rprofile

mkdir /etc/R

echo 'local({r <- getOption("repos")'>/etc/R/Rprofile.site

echo '  r["CRAN"] <- "http://192.168.0.'$A':8081/repository/r-proxy"'>>/etc/R/Rprofile.site
  
echo '  options(repos=r)'>>/etc/R/Rprofile.site
  
echo '})'>>/etc/R/Rprofile.site
## apt
### run
docker run -it --rm ubuntu bash

apt update -qq

apt install --no-install-recommends --yes software-properties-common dirmngr

wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc

add-apt-repository ppa:c2d4u.team/c2d4u4.0+
### config
echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal main restricted' > /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal-updates main restricted' >> /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal universe' >> /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal-updates universe' >> /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal multiverse' >> /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal-updates multiverse' >> /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy/ focal-backports main restricted universe multiverse' >> /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy2/ focal-cran40/' >> /etc/apt/sources.list

echo 'deb http://192.168.0.'$A':8081/repository/apt-proxy3/ focal main' >> /etc/apt/sources.list
## yum
### run
docker run -it --rm centos:8 bash
### config
rm -rf /etc/yum.repos.d/*

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
