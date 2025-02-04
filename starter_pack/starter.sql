BEGIN;

-- Step 1: Create the rmaxim schema if it does not exist
CREATE SCHEMA rmaxim;

-- Step 2: Create tables within the rmaxim schema

-- measurement_batch table
CREATE TABLE rmaxim.measurement_batch (
    id serial PRIMARY KEY, 
    start_period timestamp, 
    username varchar(64), 
    pos_x numeric, 
    pos_y numeric
);

-- measurement_types table
CREATE TABLE rmaxim.measurement_types (
    id serial PRIMARY KEY, 
    name varchar(64)
);

-- measurement_params table
CREATE TABLE rmaxim.measurement_params (
    id serial PRIMARY KEY, 
    measurement_type_id integer REFERENCES rmaxim.measurement_types(id), 
    measurement_batch_id integer REFERENCES rmaxim.measurement_batch(id), 
    height numeric, 
    temperature numeric, 
    pressure numeric, 
    wind_speed numeric, 
    wind_direction numeric, 
    bullet_speed numeric
);

-- military_positions table
CREATE TABLE rmaxim.military_positions (
    id serial PRIMARY KEY,
    position_name varchar(100) NOT NULL UNIQUE
);

-- users table
CREATE TABLE rmaxim.users (
    id serial PRIMARY KEY,
    username varchar(64) NOT NULL UNIQUE,
    position_id integer NOT NULL REFERENCES rmaxim.military_positions(id),
    full_name varchar(255),
    created_at timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp DEFAULT CURRENT_TIMESTAMP
);

-- Step 3: Alter tables to update references and modify structure

-- Add user_id column and drop username column in measurement_batch
ALTER TABLE rmaxim.measurement_batch ADD COLUMN user_id integer REFERENCES rmaxim.users(id);
ALTER TABLE rmaxim.measurement_batch DROP COLUMN username;

-- Step 4: Insert initial data into military_positions

INSERT INTO rmaxim.military_positions (position_name) VALUES
    ('Генерал армии'),
    ('Генерал-полковник'),
    ('Генерал-лейтенант'),
    ('Генерал-майор'),
    ('Подполковник'),
    ('Полковник'),
    ('Майор'),
    ('Капитан'),
    ('Старший лейтенант'),
    ('Лейтенант'),
    ('Младший лейтенант'),
    ('Сержант'),
    ('Старшина'),
    ('Ефрейтор'),
    ('Рядовой');

COMMIT;