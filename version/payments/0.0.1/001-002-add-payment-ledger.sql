CREATE TABLE IF NOT EXISTS payment_ledger (
    id SERIAL PRIMARY KEY,
    payment_id INTEGER REFERENCES payments(id),
    refund_id INTEGER REFERENCES refunds(id),
    entry_type VARCHAR(20) NOT NULL CHECK (entry_type IN ('charge', 'refund', 'adjustment')),
    amount NUMERIC(10, 2) NOT NULL,
    running_balance NUMERIC(10, 2) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_payment_ledger_payment_id ON payment_ledger(payment_id);
