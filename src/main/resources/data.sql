INSERT INTO users(full_name,email,phone,address,password_hash,role)
SELECT 'NaveenMart Admin','admin@naveenmart.com','9876543210','NaveenMart Office','pbkdf2$sha256$120000$Zml4ZWQtZGVtby1zYWx0LWFkbWluMTIz$1hP/JBGTpN5VP5Xlz1PjnnAhccKv8WFgk28xhBCdz0Q=','ADMIN'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email='admin@naveenmart.com');
INSERT INTO users(full_name,email,phone,address,password_hash,role)
SELECT 'Demo Customer','customer@naveenmart.com','9876501234','Coimbatore, Tamil Nadu','pbkdf2$sha256$120000$Zml4ZWQtZGVtby1zYWx0LWN1c3RvbWVyMTIz$kj/y8OO4bZq3nzYuQJWj4PiVc1FMn+mOqRFiGMIDNtI=','CUSTOMER'
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
