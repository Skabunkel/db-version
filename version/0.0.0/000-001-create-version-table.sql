-- 000-001: Create schema_versions table
CREATE TABLE IF NOT EXISTS schema_versions (
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    major_version   TEXT        NOT NULL,    -- e.g. "0.0.1"
    minor_version   INTEGER     NOT NULL,    -- e.g. 2
    description     TEXT,
    applied_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
