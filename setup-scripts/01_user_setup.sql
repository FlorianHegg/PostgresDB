
-- Create user and grant permissions
CREATE USER scott WITH PASSWORD 'tiger22$';
GRANT USAGE ON SCHEMA public TO scott;
ALTER DEFAULT PRIVILEGES FOR USER scott IN SCHEMA public GRANT ALL ON TABLES TO scott;
ALTER DEFAULT PRIVILEGES FOR USER scott IN SCHEMA public GRANT ALL ON SEQUENCES TO scott;
ALTER DEFAULT PRIVILEGES FOR USER scott IN SCHEMA public GRANT ALL ON FUNCTIONS TO scott;
ALTER DEFAULT PRIVILEGES FOR USER scott IN SCHEMA public GRANT ALL ON TYPES TO scott;

-- Grant data reader and data writer roles
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO scott;

-- Grant create view permission
GRANT CREATE ON SCHEMA public TO scott;

-- Connect to the vereinuser database
\c vereinuser;

-- Create user and grant permissions
CREATE USER vereinuser WITH PASSWORD 'vereinuser';
GRANT CONNECT ON DATABASE vereinuser TO vereinuser;
GRANT USAGE ON SCHEMA public TO vereinuser;
ALTER DEFAULT PRIVILEGES FOR USER vereinuser IN SCHEMA public GRANT ALL ON TABLES TO vereinuser;
ALTER DEFAULT PRIVILEGES FOR USER vereinuser IN SCHEMA public GRANT ALL ON SEQUENCES TO vereinuser;
ALTER DEFAULT PRIVILEGES FOR USER vereinuser IN SCHEMA public GRANT ALL ON FUNCTIONS TO vereinuser;
ALTER DEFAULT PRIVILEGES FOR USER vereinuser IN SCHEMA public GRANT ALL ON TYPES TO vereinuser;

-- Grant data reader and data writer roles
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO vereinuser;

-- Grant create view permission
GRANT CREATE ON SCHEMA public TO vereinuser