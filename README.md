# NaveenMart — Java 17 + Spring Boot + Maven

A simple deployment-ready e-commerce starter with **Admin login, Customer registration/login, user details, product catalog, and MySQL database**.

## Stack
- Java 17
- Spring Boot 3.5.6
- Maven
- MySQL 8+
- HTML/CSS/JavaScript single-page frontend
- HTTP session authentication
- PBKDF2 password hashing

## Database
Tables: `users`, `products`, `cart_items`, `orders`, `order_items`.
The app automatically runs `schema.sql` and `data.sql` on startup.

## Demo accounts
- Admin: `admin@naveenmart.com` / `admin123`
- Customer: `customer@naveenmart.com` / `customer123`

Change demo passwords before production use.

## Local setup
1. Install JDK 17 and Maven.
2. Start MySQL.
3. Default database settings are:
   - database: `naveen_mart`
   - username: `root`
   - password: `admin`
4. Run `mvn clean package`.
5. Run `java -jar target/naveen-mart.jar`.
6. Open `http://localhost:8080`.

Or on Windows use `RUN_WINDOWS.bat` after installing Java 17/Maven.

## Deployment
Set these environment variables on your hosting service:
`DB_URL`, `DB_USERNAME`, `DB_PASSWORD`, and optionally `PORT`.

Example:
`DB_URL=jdbc:mysql://YOUR_HOST:3306/naveen_mart?useSSL=true&serverTimezone=UTC`

Do not commit real database passwords to GitHub.

## Features
### Customer/User
- Register
- Login/logout
- View products
- Search/filter products
- View/update account details

### Admin
- Admin login
- Add products
- Delete products
- View registered users

The project includes cart/order database tables so shopping-cart and order processing can be added without redesigning the database.

## If SQL does not run

1. Open MySQL Workbench.
2. Connect to your MySQL server.
3. Open the project's `database_setup.sql`.
4. Run the **entire file** (not only one statement).
5. Refresh Schemas and open `naveen_mart`.
6. Check `users` and `products` tables.

Expected demo accounts:
- Admin: `admin@naveenmart.com` / `admin123`
- Customer: `customer@naveenmart.com` / `customer123`

If your MySQL root password is not `admin`, set it in the application's `DB_PASSWORD` environment variable or edit the local default in `application.properties`.
