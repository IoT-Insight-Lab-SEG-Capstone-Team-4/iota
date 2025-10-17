FROM timescale/timescaledb-ha:pg17
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=password
ENV POSTGRES_DB=iot_data
COPY init.sql /docker-entrypoint-initdb.d/
EXPOSE 5432