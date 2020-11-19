# nexus-data
git clone https://github.com/liujian3/nexus-data.git

docker run -d -p 8081:8081 --rm --name nexus -v /root/nexus-data:/nexus-data sonatype/nexus3
