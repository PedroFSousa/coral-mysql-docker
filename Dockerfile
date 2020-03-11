FROM mysql:5.7.20

LABEL maintainer="The INESC TEC Team <coral@lists.inesctec.pt>"
LABEL system="Coral"

COPY ./custom.cnf /etc/mysql/conf.d/
RUN chmod 644 /etc/mysql/conf.d/custom.cnf

CMD ["mysqld"]
