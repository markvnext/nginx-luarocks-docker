FROM phusion/baseimage

# Install Nginx.
RUN \
  add-apt-repository ppa:nginx/development && \
  apt-get update && \
  apt-get install -y build-essential curl git unzip libreadline-dev libncurses5-dev libpcre3-dev libssl-dev luajit lua5.1 liblua5.1-0-dev nano perl wget nginx-extras && \
  rm -rf /var/lib/apt/lists/*

# Install luarocks
RUN \
  wget http://luarocks.org/releases/luarocks-2.2.0.tar.gz && \
  tar -xzvf luarocks-2.2.0.tar.gz && \
  rm -f luarocks-2.2.0.tar.gz && \
  cd luarocks-2.2.0 && \
  ./configure && \
  make build && \
  make install && \
  make clean && \
  cd .. && \
  rm -rf luarocks-2.2.0

RUN mkdir -p /etc/service/nginx
ADD ./nginx.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

# Expose ports.
EXPOSE 80
EXPOSE 443