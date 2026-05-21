CREATE TABLE cards (
                       id           BIGSERIAL PRIMARY KEY,
                       customer_id  BIGINT NOT NULL REFERENCES customers(id),
                       last_four    VARCHAR(4) NOT NULL,
                       holder_name  VARCHAR(255) NOT NULL,
                       expiry       VARCHAR(5) NOT NULL,
                       card_type    VARCHAR(20) NOT NULL,
                       card_hash    VARCHAR(255) NOT NULL,
                       created_at   TIMESTAMP DEFAULT NOW()
);