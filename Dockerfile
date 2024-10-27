FROM ubuntu:noble

RUN apt-get update && \
    apt-get install -y git build-essential make libpcre3-dev zlib1g-dev libssl-dev && \
    git clone https://github.com/openssl/openssl.git && \
    git clone https://github.com/nginx/nginx.git && \
    cd openssl && \
    git checkout OpenSSL_1_1_1w && \
    cd ../nginx && \
    git checkout release-1.27.2 && \
    auto/configure --with-http_ssl_module --with-openssl=../openssl --with-openssl-opt=enable-ssl3 --with-openssl-opt=enable-ssl3-method --with-openssl-opt=enable-weak-ssl-ciphers && \
    make && \
    make install && \
    cd .. && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf openssl nginx

CMD ["/usr/local/nginx/sbin/nginx"]