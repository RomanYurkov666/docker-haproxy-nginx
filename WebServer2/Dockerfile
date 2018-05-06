FROM ubuntu:16.04
LABEL maintainer="Roman Yurkov <roman.jurkov@gmail.com>"

#RUN rm -f /etc/apt/sources.list.d/*

#RUN sh -c "echo 'deb-src http://us.archive.ubuntu.com/ubuntu/ precise main ' >> /etc/apt/sources.list"

RUN apt-get update && apt-get install nginx -y
RUN apt-get install haproxy -y

COPY ./haproxy.cfg /etc/haproxy
COPY ./index.html /var/www/html/index.html

RUN update-rc.d nginx enable 
RUN update-rc.d haproxy enable 
RUN echo "daemon off;" >> /etc/nginx/nginx.conf


COPY ./start.sh /tmp
CMD ["chmod","0766","/tmp/start.sh"]
CMD /tmp/start.sh
CMD ["haproxy", "-f", "/etc/haproxy/haproxy.cfg"]
