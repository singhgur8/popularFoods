-- it may be better practice to keep naming scheme consistent, such as
-- either camelcase or use _ underscores. front end uses mix however?

DROP DATABASE IF EXISTS yelp;
CREATE DATABASE yelp;

\c yelp

-- Setting up some of the column names slightly different from what front end expects
-- adjust one side to make sure its compatible
-- 10 Mil
CREATE TABLE restaurants (
    id serial PRIMARY KEY,
    name varchar NOT NULL
);

-- 20 Mil
CREATE TABLE users (
    id serial PRIMARY KEY,
    name varchar,
    avatar_url varchar NOT NULL,
    friends_number INTEGER DEFAULT 0,
    reviews_number INTEGER DEFAULT 0
);

-- (5xRestaurants) 50 Mil
CREATE TABLE dishes (
    id serial PRIMARY KEY,
    name varchar,
    price DECIMAL,
    restaurant_id INTEGER,
    photo_number INTEGER,
    review_number INTEGER,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants (id)
);

-- (2xDishes) 100 mil
CREATE TABLE reviews (
    id serial PRIMARY KEY,
    body varchar NOT NULL,
    stars INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    dish_id INTEGER NOT NULL,
    created_at VARCHAR, -- format of time from faker does not match of this
    -- helpful INTEGER DEFAULT 0, -- maybe delete these
    -- not_helpful INTEGER DEFAULT 0, -- maybe delete these
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (dish_id) REFERENCES dishes (id)
);

-- (2xDishes) 100 mil
CREATE TABLE images (
    id serial PRIMARY KEY,
    source varchar NOT NULL,
    caption varchar,
    dish_id INTEGER NOT NULL,
    FOREIGN KEY (dish_id) REFERENCES dishes (id)
);

-- add schema for indexing
-- it may help to optimize it even more if I use multi column indexing, currently only indexing one column
-- also look into increated the memory on shared buffers for postgres, this may optimize it even more


