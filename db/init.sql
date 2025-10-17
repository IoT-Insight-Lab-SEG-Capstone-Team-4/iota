-- test to create table in db

CREATE TABLE sensors (
  id SERIAL PRIMARY KEY,
  device_id TEXT,
  temperature DOUBLE PRECISION,
  timestamp TIMESTAMPTZ DEFAULT NOW()
);
