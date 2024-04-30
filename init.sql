-- Create the Flyway user
CREATE USER flyway_user WITH PASSWORD 'your_secure_password_flyway';

-- Create the application user
CREATE USER app_user WITH PASSWORD 'your_secure_password_app';



-- Grant the Flyway user necessary permissions on the database
GRANT CREATE, CONNECT ON DATABASE your_database_name TO flyway_user;

-- Assuming public schema, adjust if using a different schema
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO flyway_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO flyway_user;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO flyway_user;
GRANT USAGE, CREATE ON SCHEMA public TO flyway_user;

-- Allow the Flyway user to create new schemas and modify existing ones
ALTER USER flyway_user CREATEDB;

-- Optionally, grant the Flyway user ability to manage roles (Be cautious with this permission)
-- ALTER USER flyway_user CREATEROLE;



-- Grant the application user necessary permissions on the database
GRANT CONNECT ON DATABASE your_database_name TO app_user;

-- Grant permissions to use the public schema
GRANT USAGE ON SCHEMA public TO app_user;

-- Grant SELECT, INSERT, UPDATE, DELETE on all current tables in the public schema
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_user;

-- Ensure the application user has permissions on future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO app_user;

-- Grant privileges on all sequences (for auto-increment columns)
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO app_user;

-- Ensure the application user has permissions on future sequences
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO app_user;
