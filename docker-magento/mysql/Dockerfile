FROM alpine:3.7

RUN apk --no-cache add mysql mysql-client

COPY my.cnf /etc/mysql/my.cnf
COPY startup.sh /startup
RUN chmod +x /startup

WORKDIR /mysql

EXPOSE 3306
CMD ["/startup"]
