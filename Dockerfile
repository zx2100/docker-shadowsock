FROM ubuntu:18.04
LABEL maintanance "li-zw 244980740@qq.com"
#定义环境变量
ENV SHADOW_PATH=/usr/local/ \
    GO_PACKET=go1.11.linux-amd64 \
    SHADOW_PACKET=v1.0.0.0 \
    GO_BINPATH=/tmp/go/bin \
    GOPATH=/root/applications/go 
#添加GO和shadow程序包
WORKDIR /tmp
ADD https://dl.google.com/go/${GO_PACKET}.tar.gz /tmp
ADD https://github.com/vilsongwei/villeSock/archive/${SHADOW_PACKET}.tar.gz /tmp
COPY docker-entrypoint.sh /usr/bin/
#安装程序
RUN \
   tar xf /tmp/${GO_PACKET}.tar.gz && tar xf /tmp/${SHADOW_PACKET}.tar.gz; \ 
    mkdir ${GOPATH}/src -pv; \
    cp -r villeSock-1.0.0.0/vendor/*  ${GOPATH}/src; \
    mkdir ${GOPATH}/src/villeSock/; \
    cp -r villeSock-1.0.0.0/src ${GOPATH}/src/villeSock/; \
    cd /tmp/villeSock-1.0.0.0 && ${GO_BINPATH}/go build -ldflags "-X main.Version=1.0.0"; \
    cp -a /tmp/villeSock-1.0.0.0/villeSock-1.0.0.0 ${SHADOW_PATH}; \
    ln -s ${SHADOW_PATH}/villeSock-1.0.0.0 /bin/villsock; \ 
    rm -rf /tmp/*; \
    chmod a+x /usr/bin/docker-entrypoint.sh
    
    

#CMD villsock -conf /data/config.json
ENTRYPOINT ["/bin/docker-entrypoint.sh"]

#ENTRYPOINT 必须在CMD前面
CMD ["villsock", "-conf", "/etc/villsock/config.json"]




