-- NaveenMart complete database setup
-- Run this entire file in MySQL Workbench/phpMyAdmin/MySQL CLI.

CREATE DATABASE IF NOT EXISTS naveen_mart
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE naveen_mart;

CREATE TABLE IF NOT EXISTS users (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(160) NOT NULL UNIQUE,
  phone VARCHAR(30),
  address VARCHAR(255),
  password_hash VARCHAR(255) NOT NULL,
  role VARCHAR(20) NOT NULL DEFAULT 'CUSTOMER',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS products (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(160) NOT NULL,
  price DECIMAL(12,2) NOT NULL,
  quantity INT NOT NULL DEFAULT 0,
  category VARCHAR(80) NOT NULL,
  description TEXT,
  image_url VARCHAR(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS cart_items (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  quantity INT NOT NULL,
  UNIQUE KEY uq_cart_user_product(user_id, product_id),
  CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_cart_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS orders (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  total DECIMAL(12,2) NOT NULL,
  status VARCHAR(30) NOT NULL DEFAULT 'PLACED',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_order_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS order_items (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  order_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  product_name VARCHAR(160) NOT NULL,
  quantity INT NOT NULL,
  price DECIMAL(12,2) NOT NULL,
  CONSTRAINT fk_order_item_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Demo accounts. Passwords are: admin123 and customer123
INSERT INTO users(full_name,email,phone,address,password_hash,role)
SELECT 'NaveenMart Admin','admin@naveenmart.com','9876543210','NaveenMart Office',
'pbkdf2$sha256$120000$Zml4ZWQtZGVtby1zYWx0LWFkbWluMTIz$1hP/JBGTpN5VP5Xlz1PjnnAhccKv8WFgk28xhBCdz0Q=','ADMIN'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email='admin@naveenmart.com');

INSERT INTO users(full_name,email,phone,address,password_hash,role)
SELECT 'Demo Customer','customer@naveenmart.com','9876501234','Coimbatore, Tamil Nadu',
'pbkdf2$sha256$120000$Zml4ZWQtZGVtby1zYWx0LWN1c3RvbWVyMTIz$kj/y8OO4bZq3nzYuQJWj4PiVc1FMn+mOqRFiGMIDNtI=','CUSTOMER'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email='customer@naveenmart.com');

INSERT INTO products(name,price,quantity,category,description,image_url)
SELECT 'Wireless Headphones',1499,25,'Electronics','Bluetooth wireless headphones with comfortable ear cushions.','https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=700&q=80'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name='Wireless Headphones');

INSERT INTO products(name,price,quantity,category,description,image_url)
SELECT 'Mechanical Keyboard',2499,18,'Electronics','RGB mechanical keyboard suitable for coding and gaming.','https://images.unsplash.com/photo-1587829741301-dc798b83add3?auto=format&fit=crop&w=700&q=80'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name='Mechanical Keyboard');

INSERT INTO products(name,price,quantity,category,description,image_url)
SELECT 'Smart Watch',2999,20,'Wearables','Fitness tracking smart watch with notifications and health features.','https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=700&q=80'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name='Smart Watch');

INSERT INTO products(name,price,quantity,category,description,image_url)
SELECT 'Laptop Backpack',999,30,'Bags','Water-resistant backpack with laptop compartment.','https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=700&q=80'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name='Laptop Backpack');

INSERT INTO products(name,price,quantity,category,description,image_url)
SELECT 'Running Shoes',1899,15,'Fashion','Lightweight running shoes for daily workouts.','https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=700&q=80'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name='Running Shoes');

INSERT INTO products(name,price,quantity,category,description,image_url)
SELECT 'USB-C Hub',1299,40,'Accessories','Multi-port USB-C hub with HDMI and USB 3.0 support.','https://images.unsplash.com/photo-1625842268584-8f3296236761?auto=format&fit=crop&w=700&q=80'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name='USB-C Hub');

-- Verify after running:
SELECT id, full_name, email, role FROM users ORDER BY id;
SELECT id, name, price, quantity, category FROM products ORDER BY id;
