CREATE TABLE IF NOT EXISTS publishers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    country VARCHAR(100),
    founded_year INTEGER,
    website VARCHAR(500),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
