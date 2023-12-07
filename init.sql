-- Create a new database
CREATE DATABASE mydatabase;

-- Connect to the new database
\c mydatabase;

-- Create a table
CREATE TABLE mytable (
    id serial PRIMARY KEY,
    name VARCHAR (100),
    age INT
);

-- Insert some sample data
INSERT INTO mytable (name, age) VALUES ('John Doe', 30);
INSERT INTO mytable (name, age) VALUES ('Jane Doe', 25);