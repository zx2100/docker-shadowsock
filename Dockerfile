FROM debian:stable-slim
LABEL maintanance "li-zw 244980740@qq.com"
#定义环境变量
ENV SHADOW_PATH=/usr/local/ \
    GO_PACKET=go1.11.linux-amd64 \
    SHADOW_PACKET=v1.0.0.0 \
    GO_BINPATH=/tmp/go/bin \
    GOPATH=/root/applications/go 
#添加GO和shadow程序包
WORKDIR /tmp
COPY docker-entrypoint.sh /usr/bin/
#安装程序
RUN \
	apt update; \
	apt install -y wget; \
    wget https://dl.google.com/go/${GO_PACKET}.tar.gz; \
    wget https://github.com/vilsongwei/villeSock/archive/${SHADOW_PACKET}.tar.gz; \
    tar xf /tmp/${GO_PACKET}.tar.gz && tar xf /tmp/${SHADOW_PACKET}.tar.gz; \ 
    mkdir ${GOPATH}/src -pv; \
    cp -r /tmp/villeSock-1.0.0.0/vendor/*  ${GOPATH}/src; \
    mkdir ${GOPATH}/src/villeSock/; \
    cp -r /tmp/villeSock-1.0.0.0/src ${GOPATH}/src/villeSock/; \
    cd /tmp/villeSock-1.0.0.0 && ${GO_BINPATH}/go build -ldflags "-X main.Version=1.0.0"; \
    cp -a /tmp/villeSock-1.0.0.0/villeSock-1.0.0.0 ${SHADOW_PATH};  \
    ln -s ${SHADOW_PATH}/villeSock-1.0.0.0 /bin/villsock; \ 
    rm -rf /tmp/* ${GOPATH}; \
    chmod a+x /usr/bin/docker-entrypoint.sh
#CMD villsock -conf /data/config.json
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE ${SOCK_PORT:-10018}
#ENTRYPOINT 
CMD ["villsock", "-conf", "/etc/villsock/config.json"]




