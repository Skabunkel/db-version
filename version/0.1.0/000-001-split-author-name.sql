ALTER TABLE authors ADD COLUMN IF NOT EXISTS first_name VARCHAR(150);
ALTER TABLE authors ADD COLUMN IF NOT EXISTS last_name VARCHAR(150);

UPDATE authors
SET first_name = SPLIT_PART(name, ' ', 1),
    last_name  = SUBSTRING(name FROM POSITION(' ' IN name) + 1)
WHERE first_name IS NULL;

ALTER TABLE authors ALTER COLUMN first_name SET NOT NULL;
ALTER TABLE authors ALTER COLUMN last_name SET NOT NULL;
ALTER TABLE authors DROP COLUMN name;
