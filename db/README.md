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
  --name timescaledb-container \
  -p 5432:5432 \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=iot_data \
  my-timescaledb


### 3. Connect to the database
psql -h localhost -p 5432 -U postgres -d iot_data
Password: password

## Setting up Grafana
### 1. Running Grafana in Docker
docker run -d \
  --name grafana \
  -p 3000:3000 \
  grafana/grafana

### 2. Open Grafana
[Grafana](http://localhost:3000) installed and running
Username: admin
Password: admin

### 2. Creating a new data source
In Grafana, Connections → Add data source.
Select PostgreSQL
Select Add new data source

Fill in the following fields:

Connection
Host URL: host.docker.internal:5432
Database name: iot_data

Authentication
User: postgres
Password: password
TLS/SSL: disable

Additional settings
PostgreSQL Options
Version: 15 (or latest)
Min time interval: (leave it to 1m)
TimescaleDB: ON

Connection limits
Max open: 100
Auto max idle: ON
Max idle: 100
Max lifeline: 14400

Click Save & Test.