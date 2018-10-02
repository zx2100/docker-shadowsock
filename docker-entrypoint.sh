#!/bin/bash
#
#定义配置文件

mkdir -pv  /etc/villsock > /dev/null
cat > /etc/villsock/config.json << EOF
{
    "time_out":20,
    "user_groups":[
        {
            "server":"${SOCK_IP:-0.0.0.0}",
            "name":"myown",
            "port":${SOCK_PORT:-10018},
            "password":"${SOCK_PASS:-0000}",
            "cipher":"${SOCK_CIPHER:-AEAD_CHACHA20_POLY1305}",
            "time_out":10
        }
    ]

}
EOF
exec "$@"
