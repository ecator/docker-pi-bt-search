# docker-pi-bt-search

[bt-search](https://github.com/ecator/bt-search.git) for docker pi

## 构建镜像
这步操作可选
```
docker build -t ecat/docker-pi-bt-search .
```

## 启动容器
需要指定主机到容器的端口映射，容器端口为80
```
docker run -d --name docker-pi-bt-search -p 88:80 ecat/docker-pi-bt-search 
```
## 其他

**请在树莓派上运行**