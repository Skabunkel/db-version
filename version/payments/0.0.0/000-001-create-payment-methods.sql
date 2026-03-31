CREATE TABLE IF NOT EXISTS payment_methods (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    method_type VARCHAR(50) NOT NULL,
    provider VARCHAR(100),
    last_four VARCHAR(4),
    expiry_month SMALLINT,
    expiry_year SMALLINT,
    is_default BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_payment_methods_customer_id ON payment_methods(customer_id);
