BEGIN;
 

-- measurement_batch table
CREATE TABLE measurement_batch (
    id serial PRIMARY KEY,
    start_period timestamp,
    user_id integer REFERENCES users(id),
    pos_x numeric,
    pos_y numeric
);

-- measurement_types table
CREATE TABLE measurement_types (
    id serial PRIMARY KEY,
    name varchar(64)
);

-- measurement_params table
CREATE TABLE measurement_params (
    id serial PRIMARY KEY,
    measurement_type_id integer REFERENCES measurement_types(id),
    measurement_batch_id integer REFERENCES measurement_batch(id),
    height numeric,
    temperature numeric,
    pressure numeric,
    wind_speed numeric,
    wind_direction numeric,
    bullet_speed numeric
);

-- military_positions table
CREATE TABLE military_positions (
    id serial PRIMARY KEY,
    position_name varchar(100) NOT NULL UNIQUE
);

-- users table
CREATE TABLE users (
    id serial PRIMARY KEY,
    username varchar(64) NOT NULL UNIQUE,
    position_id integer NOT NULL REFERENCES military_positions(id),
    full_name varchar(255),
    created_at timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp DEFAULT CURRENT_TIMESTAMP
);

--  Create temperature_correction table
CREATE TABLE temperature_correction (
    id serial PRIMARY KEY,
    temperature numeric NOT NULL,
    correction numeric NOT NULL,
    interpolation_type varchar(50) NOT NULL
);

--  Insert initial data into military_positions
INSERT INTO military_positions (position_name) VALUES
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

--  Insert initial data into temperature_correction
INSERT INTO temperature_correction (temperature, correction, interpolation_type) VALUES
    (-20, -0.5, 'linear'),
    (-10, -0.3, 'linear'),
    (0, 0.0, 'linear'),
    (10, 0.2, 'linear'),
    (20, 0.4, 'linear'),
    (30, 0.6, 'linear');

COMMIT;