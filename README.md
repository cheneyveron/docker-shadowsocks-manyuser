# docker-shadowsocks-manyuser

### 用法:
    docker run -d --name=Shadowsocks \
    -p 10000-10050:10000-10050 \
    -p 10000-10050:10000-10050/udp \
    -e MANYUSER=R \
    -e MYSQL_HOST=1.2.3.4 \
    -e MYSQL_PORT=3306 \
    -e MYSQL_USER=mysqlroot \
    -e MYSQL_PASSWORD=mysqlpasswd \
    -e MYSQL_DBNAME=shadowsocks \
    -e METHOD=aes-256-cfb \
    -e PROTOCOL=auth_sha1_compatible \
    -e OBFS=http_simple_compatible \
    -e OBFS_PARAM="youku.com" \
    ywfwj2008/shadowsocks-manyuser:latest

### 参数
|变量名      	|默认参数   	|说明   |
| ------------- |:-------------:| :---|
|MANYUSER       |	            |	可用参数有：R/On <br> 当参数是R的时候则使用ShadowSocksR模式的多用户版本，否则用ShadowSocks原版的多用户模式。|
|MYSQL_HOST |	| 前端mysql域名/IP |
|MYSQL_PORT	|	3306|mysql端口|
|MYSQL_USER	|   ss|	mysql用户名(建议不要用Root账户) |
|MYSQL_PASSWORD	| ss|	mysql密码 |
|MYSQL_DBNAME	| shadowsocks |	数据库名|
|METHOD|	aes-256-cfb|	可用选项有：aes-256-cfb, aes-192-cfb, aes-128-cfb, chacha20, salsa20, rc4-md5|
|PROTOCOL|	auth_sha1_compatible|	[可选参数参考](https://github.com/ywfwj2008/docker-shadowsocks-manyuser#protocol有如下取值) |
|OBFS	|tls1.0_session_auth_compatible|	[可选参数参考](https://github.com/ywfwj2008/docker-shadowsocks-manyuser#obfs有如下取值) |
|OBFS_PARAM|   |   |
|DNS_IPV6|	false|	可用参数有：false/true|
|SPAM|  | 可用参数有：On/Off|

#### protocol有如下取值：

protocol| 说明
-------|----------
origin| 原版协议
verify_simple| 带校验的协议
verify_deflate| 带压缩的协议
verify_sha1| 带验证抗CCA攻击的协议，可兼容libev的OTA
verify_sha1_compatible| 兼容原协议版
auth_simple| 抗重放攻击的协议
auth_sha1| 带验证抗CCA攻击且抗重放攻击的协议
auth_sha1_compatible| 兼容原协议版
auth_sha1_v2| 与auth_sha1相似，去除时间验证
auth_sha1_v2_compatible| 兼容原协议版

#### obfs有如下取值：

obfs   | 说明
-------|----------
plain| 不混淆
http_simple| 伪装为http协议
http_simple_compatible| 兼容原协议版
tls_simple| 伪装为tls协议（不建议使用）
tls_simple_compatible| 兼容原协议版
random_head| 发送一个随机包再通讯的协议
random_head_compatible| 兼容原协议版
tls1.0_session_auth| 伪装为tls session握手协议，同时能抗重放攻击
tls1.0_session_auth_compatible| 兼容原协议版

注：客户端的protocol和obfs配置必须与服务端的一致。

如需要了解更多, [阅读文档](https://github.com/breakwa11/shadowsocks-rss/wiki)
