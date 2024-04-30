-- Creating a role for Flyway with login ability
CREATE ROLE flyway_user WITH LOGIN PASSWORD 'secure_password1';

-- Creating a role for the application with login ability
CREATE ROLE app_user WITH LOGIN PASSWORD 'secure_password2';

-- Granting necessary privileges to flyway_user
GRANT ALL PRIVILEGES ON DATABASE your_database_name TO flyway_user;

-- Optionally, grant this role the ability to create new schemas
ALTER ROLE flyway_user CREATEDB;


-- Granting usage on the schema to app_user
GRANT USAGE ON SCHEMA app_schema TO app_user;

-- Granting select, insert, update, and delete on all current tables in the schema
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA app_schema TO app_user;

-- Ensuring future tables in app_schema also inherit these permissions
ALTER DEFAULT PRIVILEGES IN SCHEMA app_schema GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO app_user;

-- If there are sequences in the schema, grant usage on those as well
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA app_schema TO app_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA app_schema GRANT USAGE, SELECT ON SEQUENCES TO app_user;


-- Set default search path for each role
ALTER ROLE flyway_user SET search_path TO app_schema, public;
ALTER ROLE app_user SET search_path TO app_schema, public;
