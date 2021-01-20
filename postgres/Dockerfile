FROM postgres:latest

ENV   POSTGRES_DB=guacamole_db \
      POSTGRES_PASSWORD=somepassword \
      POSTGRES_USER=guacamole_user 

VOLUME ./init:/docker-entrypoint-initdb.d:ro
VOLUME ./data:/var/lib/postgresql/data:rw

EXPOSE 5432

#WORKDIR ${PG_HOME}
#COPY ./entrypoint.sh /etc/

#ENTRYPOINT ["/etc/entrypoint.sh"]
