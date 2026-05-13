CREATE TABLE customers (
                           id         BIGSERIAL PRIMARY KEY,
                           first_name VARCHAR(100) NOT NULL,
                           last_name  VARCHAR(100) NOT NULL,
                           email      VARCHAR(255) NOT NULL UNIQUE,
                           phone      VARCHAR(20),
                           created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE employees (
                           id         BIGSERIAL PRIMARY KEY,
                           first_name VARCHAR(100) NOT NULL,
                           last_name  VARCHAR(100) NOT NULL,
                           email      VARCHAR(255) NOT NULL UNIQUE,
                           password   VARCHAR(255) NOT NULL,
                           phone      VARCHAR(20),
                           role       VARCHAR(20)  NOT NULL,
                           created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE categories (
                            id          BIGSERIAL PRIMARY KEY,
                            name        VARCHAR(100) NOT NULL,
                            description TEXT,
                            parent_id   BIGINT REFERENCES categories(id)
);

CREATE TABLE products (
                          id             BIGSERIAL PRIMARY KEY,
                          name           VARCHAR(255) NOT NULL,
                          description    TEXT,
                          price          NUMERIC(10,2) NOT NULL,
                          stock_quantity INTEGER NOT NULL DEFAULT 0,
                          category_id    BIGINT REFERENCES categories(id),
                          created_at     TIMESTAMP DEFAULT NOW()
);

CREATE TABLE orders (
                        id           BIGSERIAL PRIMARY KEY,
                        customer_id  BIGINT NOT NULL REFERENCES customers(id),
                        employee_id  BIGINT REFERENCES employees(id),
                        status       VARCHAR(20) NOT NULL DEFAULT 'NEW',
                        total_amount NUMERIC(10,2) NOT NULL,
                        order_date   TIMESTAMP DEFAULT NOW()
);

CREATE TABLE order_items (
                             id         BIGSERIAL PRIMARY KEY,
                             order_id   BIGINT NOT NULL REFERENCES orders(id),
                             product_id BIGINT NOT NULL REFERENCES products(id),
                             quantity   INTEGER NOT NULL,
                             unit_price NUMERIC(10,2) NOT NULL
);

CREATE TABLE payments (
                          id       BIGSERIAL PRIMARY KEY,
                          order_id BIGINT NOT NULL UNIQUE REFERENCES orders(id),
                          amount   NUMERIC(10,2) NOT NULL,
                          method   VARCHAR(20) NOT NULL,
                          status   VARCHAR(20) NOT NULL DEFAULT 'PENDING',
                          paid_at  TIMESTAMP
);

CREATE TABLE cart (
                      id          BIGSERIAL PRIMARY KEY,
                      customer_id BIGINT NOT NULL UNIQUE REFERENCES customers(id),
                      created_at  TIMESTAMP DEFAULT NOW()
);

CREATE TABLE cart_items (
                            id         BIGSERIAL PRIMARY KEY,
                            cart_id    BIGINT NOT NULL REFERENCES cart(id),
                            product_id BIGINT NOT NULL REFERENCES products(id),
                            quantity   INTEGER NOT NULL
);