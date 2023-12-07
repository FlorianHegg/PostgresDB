FROM postgres:latest


ENV POSTGRES_DB VEREINUSER
ENV POSTGRES_USER VEREINUSER
ENV POSTGRES_PASSWORD VEREINUSER

RUN mkdir -p /docker-entrypoint-initdb.d
RUN chmod +x /docker-entrypoint.sh


COPY init.sql /docker-entrypoint-initdb.d/

COPY /setup-scripts/01_setup_users.sql /docker-entrypoint-initdb.d/
COPY /setup-scripts/02_emp-dept_tables.sql /docker-entrypoint-initdb.d/
COPY /setup-scripts/03_emp-dept_data.sql /docker-entrypoint-initdb.d/
COPY /setup-scripts/04_verein_tables.sql /docker-entrypoint-initdb.d/
COPY /setup-scripts/05_verein_data.sql /docker-entrypoint-initdb.d/

EXPOSE 5432

CMD ["postgres"]
