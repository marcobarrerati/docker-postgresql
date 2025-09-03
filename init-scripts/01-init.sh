#!/bin/bash
# PostgreSQL initialization script
# This script runs when the database is first created

set -e

# Create additional databases if needed
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
#     CREATE DATABASE additional_db;
#     CREATE USER app_user WITH ENCRYPTED PASSWORD 'app_password';
#     GRANT ALL PRIVILEGES ON DATABASE additional_db TO app_user;
# EOSQL

# Enable extensions
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Enable commonly used extensions
    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    CREATE EXTENSION IF NOT EXISTS "pg_stat_statements";
    CREATE EXTENSION IF NOT EXISTS "pgcrypto";
    
    -- Create a sample table (remove if not needed)
    CREATE TABLE IF NOT EXISTS health_check (
        id SERIAL PRIMARY KEY,
        status VARCHAR(50) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    
    INSERT INTO health_check (status) VALUES ('initialized');
EOSQL

echo "PostgreSQL initialization completed successfully!"
