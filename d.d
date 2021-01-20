version: '3.7'

networks:
  guacamole-net:

services:

  postgres:
    image: postgres
    deploy:
      replicas: 1
      placement:
        constraints: [node.role == manager]
      restart_policy:
        condition: any
#        windows: 15m
#    volumes:
#      - /root/guac/script.sh:/etc
#    command: >
#      /etc/script.sh
#    environment:
#      - POSTGRES_HOSTNAME=postgres
#      - POSTGRES_PORT=5432
#      - POSTGRES_DATABASE=guacamole_db
#      - POSTGRES_USER=guacamole_user
#      - POSTGRES_PASSWORD=somepassword
#    volumes:
#      - pg-primary-vol:/pgdata
    volumes:
#      - ./init:/docker-entrypoint-initdb.d
#      - ./data:/var/lib/postgresql/data
      - /root/guacamole/guacamole_postgres_database:/var/lib/postgresql/data
    ports:
      - 5432:5432
    networks:
      - guacamole-net
 #   deploy:
 #     placement:
 #       constraints:
 #       - node.labels.type == primary
 #       - node.role == worker

  guacd:
    image: guacamole/guacd
    deploy:
      replicas: 1
      placement:
        constraints: [node.role == manager]
      restart_policy:
        condition: on-failure
    networks:
      - guacamole-net
    ports:
      - 4822:4822

  guac:
    image: guacamole/guacamole
    deploy:
      replicas: 1
      placement:
        constraints: [node.role == manager]
      restart_policy:
        condition: on-failure
    environment:
      - POSTGRES_HOSTNAME=postgres
      - POSTGRES_PORT=5432
      - POSTGRES_DATABASE=guacamole_db
      - POSTGRES_USER=guacamole_user
      - POSTGRES_PASSWORD=somepassword
      - GUACD_HOSTNAME=guacd
    networks:
      - guacamole-net
    ports:
      - 8080:8080
    depends_on:
      - postgres
      - guacd

#volumes:
#  pg-primary-vol:
