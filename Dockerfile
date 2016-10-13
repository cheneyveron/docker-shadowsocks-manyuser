FROM centos:latest

MAINTAINER ywfwj2008 <ywfwj2008@163.com>

ENV INSTALL_DIR=/shadowsocks

RUN yum -y update && \
    yum install -y python-setuptools wget git && easy_install pip 
RUN pip install cymysql
RUN yum -y groupinstall "Development Tools" && \
    wget https://github.com/jedisct1/libsodium/releases/download/1.0.10/libsodium-1.0.10.tar.gz && \
    tar xf libsodium-1.0.10.tar.gz &&  \
    cd libsodium-1.0.10 && \
    ./configure && make -j2 && make install && \
    echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf && \
    ldconfig
RUN git clone -b manyuser https://github.com/glzjin/shadowsocks.git $INSTALL_DIR && \
	cp $INSTALL_DIR/apiconfig.py $INSTALL_DIR/userapiconfig.py && \
	cp $INSTALL_DIR/config.json $INSTALL_DIR/user-config.json

ADD run.sh /run.sh
RUN chmod +x /run.sh

#EXPOSE 50000-50100

# Configure container to run as an executable
ENTRYPOINT ["/run.sh"]

CMD ["python", "/shadowsocks/server.py"]