# 🗄️ TimescaleDB Docker Setup

Dockerfile to run a PostgreSQL 17 + TimescaleDB instance.

## 🧰 Prerequisites
- [Docker](https://docs.docker.com/get-docker/) installed and running

## 🚀 Build and Run

### 1. Build the image
```bash
docker build -t my-timescaledb .

### 2. Run the image
docker run -d \
  --name timescaledb \     
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=iot_db \  
  my-timescaledb



  #ignore this
  docker run -d \
  --name timescaledb-container \
  -p 5432:5432 \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=iot_data \
  timescale/timescaledb-ha:pg17


### 3. Connect to the database
psql -h localhost -U postgres -d iot_data

Password: password

## Resetting the container
docker rm -f timescaledb-container













# Alternative port
docker build -t my-timescaledb .

docker run -d \
  --name timescaledb-test \
  -p 5433:5432 \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=iot_test \
  my-timescaledb

psql -h localhost -p 5433 -U postgres -d iot_test
