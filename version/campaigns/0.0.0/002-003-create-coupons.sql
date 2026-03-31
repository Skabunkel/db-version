CREATE TABLE IF NOT EXISTS coupons (
    id SERIAL PRIMARY KEY,
    discount_id INTEGER NOT NULL REFERENCES discounts(id) ON DELETE CASCADE,
    code VARCHAR(50) NOT NULL UNIQUE,
    is_single_use BOOLEAN NOT NULL DEFAULT TRUE,
    redeemed_by INTEGER,
    redeemed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_coupons_discount_id ON coupons(discount_id);
CREATE INDEX IF NOT EXISTS idx_coupons_code ON coupons(code);
