# base MySQL image
FROM mysql:8.0

# config file
COPY ./my.cnf /etc/mysql/conf.d/my.cnf

# init script
COPY ./lamsut.sql /docker-entrypoint-initdb.d/

# expose MySQL default port
EXPOSE 3306

# run the container
CMD ["mysqld"]
