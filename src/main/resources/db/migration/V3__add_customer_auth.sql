ALTER TABLE customers ADD COLUMN password VARCHAR(255);

CREATE TABLE favorites (
                           id         BIGSERIAL PRIMARY KEY,
                           customer_id BIGINT NOT NULL REFERENCES customers(id),
                           product_id  BIGINT NOT NULL REFERENCES products(id),
                           created_at  TIMESTAMP DEFAULT NOW(),
                           UNIQUE(customer_id, product_id)
);