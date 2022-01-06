docker run --restart=always -itd -v /root/:/tmp/nginx_upload -p 80:80 -p 8080:8080 --name nginx_upload liujian3lj7/nginx_upload
rm -rf nexus-data/tmp/*
rm -rf nexus-data/cache/*
rm -rf nexus-data/log/*
tar -cjf 1 nexus-data/
