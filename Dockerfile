# Use an official PostgreSQL image as the base image
FROM postgres:latest

# Set environment variables
ENV POSTGRES_DB VEREINUSER
ENV POSTGRES_USER VEREINUSER
ENV POSTGRES_PASSWORD VEREINUSER

# Create a directory to store custom initialization scripts
RUN mkdir -p /docker-entrypoint-initdb.d

# Copy custom initialization scripts to the container
COPY init.sql /docker-entrypoint-initdb.d/

COPY /setup-scripts/01_setup_users.sql /docker-entrypoint-initdb.d/
COPY /setup-scripts/02_emp-dept_tables.sql /docker-entrypoint-initdb.d/
COPY /setup-scripts/03_emp-dept_data.sql /docker-entrypoint-initdb.d/
COPY /setup-scripts/04_verein_tables.sql /docker-entrypoint-initdb.d/
COPY /setup-scripts/05_verein_data.sql /docker-entrypoint-initdb.d/

# Expose the PostgreSQL port
EXPOSE 5432

# CMD instruction to start PostgreSQL when the container starts
CMD ["postgres"]
