# 容器化环境自动构建
FROM resin/rpi-raspbian
LABEL version="0.1"
LABEL description="bt-search-docker for docker pi"
MAINTAINER ecat <qule520@126.com>

# 环境变量配置
ENV www_root /srv/www
ENV www_name bt-search
ENV git_repo "https://github.com/ecator/bt-search.git"

ENV nginx_default /etc/nginx/sites-available/default

# 软件环境安装
RUN apt-get update \
	&& apt-get install -y git nginx php5-fpm php5-cli php5-curl php5-gd php5-mcrypt php5-cgi nodejs npm \
	&& rm -rf /var/lib/apt/lists/*

RUN npm install -g bower \
	&& mkdir -p $www_root


WORKDIR $www_root

RUN git clone $git_repo --depth 1

WORKDIR $www_name

# 包依赖安装
RUN php -r "readfile('https://getcomposer.org/installer');" | php
RUN php composer.phar install \
	&& nodejs /usr/local/bin/bower install --allow-root


# 解决权限问题
RUN	chmod -R 755 * \
	&& chown -R www-data:www-data /srv

# 复制配置文件
COPY $nginx_default $nginx_default

# 入口脚本
COPY run.sh /

RUN chmod 777 /run.sh

EXPOSE 80/tcp

CMD /run.sh