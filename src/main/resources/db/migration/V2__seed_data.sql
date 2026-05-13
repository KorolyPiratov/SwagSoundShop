-- Категории
INSERT INTO categories (name, description) VALUES                                       ('Гитары', 'Акустические и электрогитары'),
    ('Клавишные', 'Синтезаторы и пианино'),
    ('Ударные', 'Барабаны и перкуссия'),
    ('Аксессуары', 'Струны, медиаторы, стойки');

INSERT INTO categories (name, description, parent_id) VALUES
    ('Акустические', 'Акустические гитары', 1),
    ('Электрогитары', 'Электрогитары', 1),
    ('Синтезаторы', 'Синтезаторы', 2),
    ('Пианино', 'Цифровые пианино', 2);

-- Товары
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES
    ('Fender Stratocaster', 'Классическая электрогитара', 89999.00, 5, 6),
    ('Gibson Les Paul', 'Легендарная электрогитара', 120000.00, 3, 6),
    ('Yamaha F310', 'Акустическая гитара для начинающих', 15999.00, 10, 5),
    ('Roland FP-30', 'Цифровое пианино 88 клавиш', 55000.00, 4, 8),
    ('Korg Minilogue', 'Аналоговый синтезатор', 45000.00, 6, 7);

-- Сотрудники (пароль для всех: "password123" — BCrypt хэш)
INSERT INTO employees (first_name, last_name, email, password, phone, role) VALUES
    ('Иван', 'Админов', 'admin@swagsound.ru',
    'Admin1', '+79001112233', 'ADMIN'),
    ('Мария', 'Менеджерова', 'manager@swagsound.ru',
    'Meneger2', '+79002223344', 'MANAGER'),
    ('Пётр', 'Продавцов', 'seller@swagsound.ru',
    'Prodavec3', '+79003334455', 'SELLER');